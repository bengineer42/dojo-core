
impl UnmappedModelIntrospect<> of dojo::meta::introspect::Introspect<UnmappedModel<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(1)
    }

    fn layout() -> dojo::meta::Layout {
        dojo::meta::Layout::Struct(
            array![
            dojo::meta::FieldLayout {
                    selector: 1507022272292183979662117392033651672012160643262248578574686355637156844799,
                    layout: dojo::meta::introspect::Introspect::<u32>::layout()
                }
            ].span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'UnmappedModel',
                attrs: array![].span(),
                children: array![
                dojo::meta::introspect::Member {
            name: 'id',
            attrs: array!['key'].span(),
            ty: dojo::meta::introspect::Introspect::<u32>::ty()
        },
dojo::meta::introspect::Member {
            name: 'data',
            attrs: array![].span(),
            ty: dojo::meta::introspect::Introspect::<u32>::ty()
        }

                ].span()
            }
        )
    }
}
        #[derive(Drop, Serde)]
pub struct UnmappedModelEntity {
    __id: felt252, // private field
    pub data: u32,

} 

type UnmappedModelKeyType = u32;

pub impl UnmappedModelModelKeyImpl of dojo::model::members::key::KeyParserTrait<UnmappedModel, UnmappedModelKeyType>{
    fn _key(self: @UnmappedModel) -> UnmappedModelKeyType {
        *self.id
    }
} 

pub impl UnmappedModelKeyImpl = dojo::model::members::key::KeyImpl<UnmappedModelKeyType>;

// Impl to get the static attributes of a model
pub mod unmapped_model_attributes {
    use super::UnmappedModel;
    pub impl UnmappedModelAttributesImpl<T> of dojo::model::ModelAttributes<T>{
    
        #[inline(always)]
        fn version() -> u8 {
            1
        }
       
        #[inline(always)]
        fn selector() -> felt252 {
            2121677522301266199932185231203700911038491669414600921327112501140572889695
        }
        
        #[inline(always)]
        fn name_hash() -> felt252 {
            1584724822170750266186772388462516998473746754626320551640105895944158933865
        }
    
        #[inline(always)]
        fn namespace_hash() -> felt252 {
            2105053275505968356473152143469476972982003638601945818721192368664247421348
        }
    
        #[inline(always)]
        fn name() -> ByteArray {
            "UnmappedModel"
        }
        
        #[inline(always)]
        fn namespace() -> ByteArray {
            "ns1"
        }
        
        #[inline(always)]
        fn tag() -> ByteArray {
            "ns1-UnmappedModel"
        }
    
        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Introspect::<UnmappedModel>::layout()
        }
    }
    
}


pub impl UnmappedModelAttributes = unmapped_model_attributes::UnmappedModelAttributesImpl<UnmappedModel>;
pub impl UnmappedModelEntityAttributes = unmapped_model_attributes::UnmappedModelAttributesImpl<UnmappedModelEntity>;

pub impl UnmappedModelModelSerdeImpl of dojo::model::model::ModelSerde<UnmappedModel>{
    fn _keys(self: @UnmappedModel) -> Span<felt252> {
        dojo::model::members::MemberTrait::<UnmappedModelKeyType>::serialize(
            @UnmappedModelModelKeyImpl::_key(self)
        )
    }
    fn _values(self: @UnmappedModel) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.data, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn _keys_values(self: @UnmappedModel) -> (Span<felt252>, Span<felt252>) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.data, ref serialized);

        (Self::_keys(self), core::array::ArrayTrait::span(@serialized))
    }
}

pub impl UnmappedModelEntitySerdeImpl of dojo::model::entity::EntitySerde<UnmappedModelEntity>{
    fn _id(self: @UnmappedModelEntity) -> felt252 {
        *self.__id
    }
    fn _values(self: @UnmappedModelEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.data, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn _id_values(self: @UnmappedModelEntity) -> (felt252, Span<felt252>) {
        (*self.__id, Self::_values(self))
    }
}


pub impl UnmappedModelModelImpl = dojo::model::model::ModelImpl<UnmappedModel>;
pub impl UnmappedModelStore = dojo::model::model::ModelStoreImpl<UnmappedModel>;

pub impl UnmappedModelEntityImpl = dojo::model::entity::EntityImpl<UnmappedModelEntity>;
pub impl UnmappedModelEntityStore = dojo::model::entity::EntityStoreImpl<UnmappedModelEntity>;


//////


#[starknet::interface]
pub trait IUnmappedModel<T> {
    fn ensure_abi(self: @T, model: UnmappedModel);
}

#[starknet::contract]
pub mod unmapped_model {
    use super::UnmappedModel;
    use super::IUnmappedModel;
    use super::UnmappedModelAttributes;
    use super::UnmappedModelModelImpl;
    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState>{
        fn name(self: @ContractState) -> ByteArray {
            UnmappedModelAttributes::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            UnmappedModelAttributes::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            UnmappedModelAttributes::tag()
        }

        fn version(self: @ContractState) -> u8 {
            UnmappedModelAttributes::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            UnmappedModelAttributes::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            UnmappedModelAttributes::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            UnmappedModelAttributes::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::meta::Introspect::<UnmappedModel>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::meta::layout::compute_packed_size(UnmappedModelAttributes::layout())
        }

        fn layout(self: @ContractState) -> dojo::meta::Layout {
            UnmappedModelAttributes::layout()
        }

        fn schema(self: @ContractState) -> dojo::meta::introspect::Ty {
            dojo::meta::Introspect::<UnmappedModel>::ty()
        }
    }

    #[abi(embed_v0)]
    impl UnmappedModelImpl of IUnmappedModel<ContractState>{
        fn ensure_abi(self: @ContractState, model: UnmappedModel) {
        }
    }
}


#[cfg(target: "test")]
pub impl UnmappedModelModelTestImpl of dojo::model::ModelTest<UnmappedModel> {
   fn set_test(
        self: @UnmappedModel,
        world: dojo::world::IWorldDispatcher
    ) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            UnmappedModelAttributes::selector(),
            dojo::model::ModelIndex::Keys(UnmappedModelModelStore::keys(self)),
            UnmappedModelModelStore::values(self),
            dojo::model::introspect::<UnmappedModel>::layout()

        );
    }

    fn delete_test(
        self: @UnmappedModel,
        world: dojo::world::IWorldDispatcher
    ) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            UnmappedModelAttributes::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::keys(self)),
            dojo::model::introspect::<UnmappedModel>::layout()

        );
    }
}

#[cfg(target: "test")]
pub impl UnmappedModelModelEntityTestImpl of dojo::model::ModelEntityTest<UnmappedModelEntity> {
    fn update_test(self: @UnmappedModelEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            UnmappedModelAttributes::selector(),
            dojo::model::ModelIndex::Id(UnmappedModelEntityStore::id(self)),
            UnmappedModelModelEntityImpl::values(self),
            dojo::model::introspect::<UnmappedModel>::layout()
        );
    }

    fn delete_test(self: @UnmappedModelEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            UnmappedModelAttributes::selector(),
            dojo::model::ModelIndex::Id(UnmappedModelEntityStore::id(self)),
            dojo::model::introspect::<UnmappedModel>::layout()
        );
    }
}