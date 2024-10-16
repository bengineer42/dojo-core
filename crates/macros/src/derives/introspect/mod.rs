use std::collections::HashMap;

use cairo_lang_macro::{Diagnostic, TokenStream};
use cairo_lang_syntax::node::ast::{
    GenericParam, ItemEnum, ItemStruct, OptionWrappedGenericParamList,
};
use cairo_lang_syntax::node::db::SyntaxGroup;
use cairo_lang_syntax::node::Terminal;

use crate::diagnostic_ext::DiagnosticsExt;
use crate::token_stream_ext::TokenStreamExt;

mod layout;
mod size;
mod ty;
mod utils;

/// Generate the introspect of a Struct
pub fn handle_introspect_struct(
    db: &dyn SyntaxGroup,
    diagnostics: &mut Vec<Diagnostic>,
    struct_ast: ItemStruct,
    packed: bool,
) -> TokenStream {
    let struct_name = struct_ast.name(db).text(db).into();
    let struct_size = size::compute_struct_layout_size(db, &struct_ast, packed);
    let ty = ty::build_struct_ty(db, &struct_name, &struct_ast);

    let layout = if packed {
        layout::build_packed_struct_layout(db, diagnostics, &struct_ast)
    } else {
        format!(
            "dojo::meta::Layout::Struct(
            array![
            {}
            ].span()
        )",
            layout::build_field_layouts(db, diagnostics, &struct_ast)
        )
    };

    let (gen_types, gen_impls) = build_generic_types_and_impls(db, struct_ast.generic_params(db));

    generate_introspect(
        &struct_name,
        &struct_size,
        &gen_types,
        gen_impls,
        &layout,
        &ty,
    )
}

/// Generate the introspect of a Enum
pub fn handle_introspect_enum(
    db: &dyn SyntaxGroup,
    diagnostics: &mut Vec<Diagnostic>,
    enum_ast: ItemEnum,
    packed: bool,
) -> TokenStream {
    let enum_name = enum_ast.name(db).text(db).into();
    let variant_sizes = size::compute_enum_variant_sizes(db, &enum_ast);

    let layout = if packed {
        if size::is_enum_packable(&variant_sizes) {
            layout::build_packed_enum_layout(db, diagnostics, &enum_ast)
        } else {
            diagnostics.push_error(format!(
                "To be packed, all variants must have fixed layout of same size. {}",
                enum_ast.name(db).text(db).to_string()
            ));
            "ERROR".to_string()
        }
    } else {
        format!(
            "dojo::meta::Layout::Enum(
            array![
            {}
            ].span()
        )",
            layout::build_variant_layouts(db, diagnostics, &enum_ast)
        )
    };

    let (gen_types, gen_impls) = build_generic_types_and_impls(db, enum_ast.generic_params(db));
    let enum_size = size::compute_enum_layout_size(&variant_sizes, packed);
    let ty = ty::build_enum_ty(db, &enum_name, &enum_ast);

    generate_introspect(&enum_name, &enum_size, &gen_types, gen_impls, &layout, &ty)
}

/// Generate the introspect impl for a Struct or an Enum,
/// based on its name, size, layout and Ty.
fn generate_introspect(
    name: &String,
    size: &String,
    generic_types: &[String],
    generic_impls: String,
    layout: &String,
    ty: &String,
) -> TokenStream {
    TokenStream::interpolate_patched(
        "
impl $name$Introspect<$generics$> of dojo::meta::introspect::Introspect<$name$<$generics_types$>> \
         {
    #[inline(always)]
    fn size() -> Option<usize> {
        $size$
    }

    fn layout() -> dojo::meta::Layout {
        $layout$
    }

    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        $ty$
    }
}
        ",
        &HashMap::from([
            ("name".to_string(), name.to_string()),
            ("generics".to_string(), generic_impls),
            (
                "generics_types".to_string(),
                generic_types.join(", "),
            ),
            ("size".to_string(), size.to_string()),
            ("layout".to_string(), layout.to_string()),
            ("ty".to_string(), ty.to_string()),
        ]),
    )
}

// Extract generic type information and build the
// type and impl information to add to the generated introspect
fn build_generic_types_and_impls(
    db: &dyn SyntaxGroup,
    generic_params: OptionWrappedGenericParamList,
) -> (Vec<String>, String) {
    let generic_types =
        if let OptionWrappedGenericParamList::WrappedGenericParamList(params) = generic_params {
            params
                .generic_params(db)
                .elements(db)
                .iter()
                .filter_map(|el| {
                    if let GenericParam::Type(typ) = el {
                        Some(typ.name(db).text(db).to_string())
                    } else {
                        None
                    }
                })
                .collect::<Vec<_>>()
        } else {
            vec![]
        };

    let generic_impls = generic_types
        .iter()
        .map(|g| format!("{g}, impl {g}Introspect: dojo::meta::introspect::Introspect<{g}>"))
        .collect::<Vec<_>>()
        .join(", ");

    (generic_types, generic_impls)
}
