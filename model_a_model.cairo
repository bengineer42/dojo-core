
impl ModelAIntrospect<> of dojo::meta::introspect::Introspect<ModelA<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(1)
    }

    fn layout() -> dojo::meta::Layout {
        dojo::meta::Layout::Struct(
            array![
            dojo::meta::FieldLayout {
                    selector: 1247650000417123719142308899207783949116295758836619114717800638088997106123,
                    layout: dojo::meta::introspect::Introspect::<felt252>::layout()
                }
            ].span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'ModelA',
                attrs: array![].span(),
                children: array![
                dojo::meta::introspect::Member {
            name: 'id',
            attrs: array!['key'].span(),
            ty: dojo::meta::introspect::Introspect::<u32>::ty()
        },
dojo::meta::introspect::Member {
            name: 'a',
            attrs: array![].span(),
            ty: dojo::meta::introspect::Introspect::<felt252>::ty()
        }

                ].span()
            }
        )
    }
}
        #[derive(Drop, Serde)]
pub struct ModelAEntity {
    __id: felt252, // private field
    pub a: felt252,

} 

type ModelAKeyType = u32;

pub impl ModelAModelKeyImpl of dojo::model::members::key::KeyParserTrait<ModelA, ModelAKeyType>{
    fn _key(self: @ModelA) -> ModelAKeyType {
        *self.id
    }
} 

pub impl ModelAKeyImpl = dojo::model::members::key::KeyImpl<ModelAKeyType>;

// Impl to get the static attributes of a model
pub mod model_a_attributes {
    use super::ModelA;
    pub impl ModelAAttributesImpl<T> of dojo::model::ModelAttributes<T>{
    
        #[inline(always)]
        fn version() -> u8 {
            1
        }
       
        #[inline(always)]
        fn selector() -> felt252 {
            2115297925538093494275369181007694382153927751864380943867975361938518656930
        }
        
        #[inline(always)]
        fn name_hash() -> felt252 {
            2080965990666771880050093411012346882652182717378010088239132234603805597864
        }
    
        #[inline(always)]
        fn namespace_hash() -> felt252 {
            2676555803512978187621970457973650611834707214703290319164728220764632594214
        }
    
        #[inline(always)]
        fn name() -> ByteArray {
            "ModelA"
        }
        
        #[inline(always)]
        fn namespace() -> ByteArray {
            "ds"
        }
        
        #[inline(always)]
        fn tag() -> ByteArray {
            "ds-ModelA"
        }
    
        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Introspect::<ModelA>::layout()
        }
    }
    
}


pub impl ModelAAttributes = model_a_attributes::ModelAAttributesImpl<ModelA>;
pub impl ModelAEntityAttributes = model_a_attributes::ModelAAttributesImpl<ModelAEntity>;

pub impl ModelAModelSerdeImpl of dojo::model::model::ModelSerde<ModelA>{
    fn _keys(self: @ModelA) -> Span<felt252> {
        dojo::model::members::MemberTrait::<ModelAKeyType>::serialize(
            @ModelAModelKeyImpl::_key(self)
        )
    }
    fn _values(self: @ModelA) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.a, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn _keys_values(self: @ModelA) -> (Span<felt252>, Span<felt252>) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.a, ref serialized);

        (Self::_keys(self), core::array::ArrayTrait::span(@serialized))
    }
}

pub impl ModelAEntitySerdeImpl of dojo::model::entity::EntitySerde<ModelAEntity>{
    fn _id(self: @ModelAEntity) -> felt252 {
        *self.__id
    }
    fn _values(self: @ModelAEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.a, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn _id_values(self: @ModelAEntity) -> (felt252, Span<felt252>) {
        (*self.__id, Self::_values(self))
    }
}


pub impl ModelAModelImpl = dojo::model::model::ModelImpl<ModelA>;
pub impl ModelAStore = dojo::model::model::ModelStoreImpl<ModelA>;

pub impl ModelAEntityImpl = dojo::model::entity::EntityImpl<ModelAEntity>;
pub impl ModelAEntityStore = dojo::model::entity::EntityStoreImpl<ModelAEntity>;


//////


#[starknet::interface]
pub trait IModelA<T> {
    fn ensure_abi(self: @T, model: ModelA);
}

#[starknet::contract]
pub mod model_a {
    use super::ModelA;
    use super::IModelA;
    use super::ModelAAttributes;
    use super::ModelAModelImpl;
    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState>{
        fn name(self: @ContractState) -> ByteArray {
            ModelAAttributes::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            ModelAAttributes::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            ModelAAttributes::tag()
        }

        fn version(self: @ContractState) -> u8 {
            ModelAAttributes::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            ModelAAttributes::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            ModelAAttributes::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            ModelAAttributes::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::meta::Introspect::<ModelA>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::meta::layout::compute_packed_size(ModelAAttributes::layout())
        }

        fn layout(self: @ContractState) -> dojo::meta::Layout {
            ModelAAttributes::layout()
        }

        fn schema(self: @ContractState) -> dojo::meta::introspect::Ty {
            dojo::meta::Introspect::<ModelA>::ty()
        }
    }

    #[abi(embed_v0)]
    impl ModelAImpl of IModelA<ContractState>{
        fn ensure_abi(self: @ContractState, model: ModelA) {
        }
    }
}


#[cfg(target: "test")]
pub impl ModelAModelTestImpl of dojo::model::ModelTest<ModelA> {
   fn set_test(
        self: @ModelA,
        world: dojo::world::IWorldDispatcher
    ) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            ModelAAttributes::selector(),
            dojo::model::ModelIndex::Keys(ModelAModelStore::keys(self)),
            ModelAModelStore::values(self),
            dojo::model::introspect::<ModelA>::layout()

        );
    }

    fn delete_test(
        self: @ModelA,
        world: dojo::world::IWorldDispatcher
    ) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            ModelAAttributes::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::keys(self)),
            dojo::model::introspect::<ModelA>::layout()

        );
    }
}

#[cfg(target: "test")]
pub impl ModelAModelEntityTestImpl of dojo::model::ModelEntityTest<ModelAEntity> {
    fn update_test(self: @ModelAEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            ModelAAttributes::selector(),
            dojo::model::ModelIndex::Id(ModelAEntityStore::id(self)),
            ModelAModelEntityImpl::values(self),
            dojo::model::introspect::<ModelA>::layout()
        );
    }

    fn delete_test(self: @ModelAEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            ModelAAttributes::selector(),
            dojo::model::ModelIndex::Id(ModelAEntityStore::id(self)),
            dojo::model::introspect::<ModelA>::layout()
        );
    }
}