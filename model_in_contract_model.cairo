
impl ModelInContractIntrospect<> of dojo::meta::introspect::Introspect<ModelInContract<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(1)
    }

    fn layout() -> dojo::meta::Layout {
        dojo::meta::Layout::Struct(
            array![
            dojo::meta::FieldLayout {
                    selector: 1247650000417123719142308899207783949116295758836619114717800638088997106123,
                    layout: dojo::meta::introspect::Introspect::<u8>::layout()
                }
            ].span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'ModelInContract',
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
            ty: dojo::meta::introspect::Introspect::<u8>::ty()
        }

                ].span()
            }
        )
    }
}
        #[derive(Drop, Serde)]
pub struct ModelInContractEntity {
    __id: felt252, // private field
    pub a: u8,

} 

type ModelInContractKeyType = u32;

pub impl ModelInContractModelKeyImpl of dojo::model::members::key::KeyParserTrait<ModelInContract, ModelInContractKeyType>{
    fn _key(self: @ModelInContract) -> ModelInContractKeyType {
        *self.id
    }
} 

pub impl ModelInContractKeyImpl = dojo::model::members::key::KeyImpl<ModelInContractKeyType>;

// Impl to get the static attributes of a model
pub mod model_in_contract_attributes {
    use super::ModelInContract;
    pub impl ModelInContractAttributesImpl<T> of dojo::model::ModelAttributes<T>{
    
        #[inline(always)]
        fn version() -> u8 {
            1
        }
       
        #[inline(always)]
        fn selector() -> felt252 {
            2171000299919187181300912962039085001664710317998298851771807578477862453089
        }
        
        #[inline(always)]
        fn name_hash() -> felt252 {
            146413447403737200771847515199806857414544937478680826620481942924387483464
        }
    
        #[inline(always)]
        fn namespace_hash() -> felt252 {
            2676555803512978187621970457973650611834707214703290319164728220764632594214
        }
    
        #[inline(always)]
        fn name() -> ByteArray {
            "ModelInContract"
        }
        
        #[inline(always)]
        fn namespace() -> ByteArray {
            "ds"
        }
        
        #[inline(always)]
        fn tag() -> ByteArray {
            "ds-ModelInContract"
        }
    
        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Introspect::<ModelInContract>::layout()
        }
    }
    
}


pub impl ModelInContractAttributes = model_in_contract_attributes::ModelInContractAttributesImpl<ModelInContract>;
pub impl ModelInContractEntityAttributes = model_in_contract_attributes::ModelInContractAttributesImpl<ModelInContractEntity>;

pub impl ModelInContractModelSerdeImpl of dojo::model::model::ModelSerde<ModelInContract>{
    fn _keys(self: @ModelInContract) -> Span<felt252> {
        dojo::model::members::MemberTrait::<ModelInContractKeyType>::serialize(
            @ModelInContractModelKeyImpl::_key(self)
        )
    }
    fn _values(self: @ModelInContract) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.a, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn _keys_values(self: @ModelInContract) -> (Span<felt252>, Span<felt252>) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.a, ref serialized);

        (Self::_keys(self), core::array::ArrayTrait::span(@serialized))
    }
}

pub impl ModelInContractEntitySerdeImpl of dojo::model::entity::EntitySerde<ModelInContractEntity>{
    fn _id(self: @ModelInContractEntity) -> felt252 {
        *self.__id
    }
    fn _values(self: @ModelInContractEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.a, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn _id_values(self: @ModelInContractEntity) -> (felt252, Span<felt252>) {
        (*self.__id, Self::_values(self))
    }
}


pub impl ModelInContractModelImpl = dojo::model::model::ModelImpl<ModelInContract>;
pub impl ModelInContractStore = dojo::model::model::ModelStoreImpl<ModelInContract>;

pub impl ModelInContractEntityImpl = dojo::model::entity::EntityImpl<ModelInContractEntity>;
pub impl ModelInContractEntityStore = dojo::model::entity::EntityStoreImpl<ModelInContractEntity>;


//////


#[starknet::interface]
pub trait IModelInContract<T> {
    fn ensure_abi(self: @T, model: ModelInContract);
}

#[starknet::contract]
pub mod model_in_contract {
    use super::ModelInContract;
    use super::IModelInContract;
    use super::ModelInContractAttributes;
    use super::ModelInContractModelImpl;
    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState>{
        fn name(self: @ContractState) -> ByteArray {
            ModelInContractAttributes::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            ModelInContractAttributes::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            ModelInContractAttributes::tag()
        }

        fn version(self: @ContractState) -> u8 {
            ModelInContractAttributes::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            ModelInContractAttributes::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            ModelInContractAttributes::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            ModelInContractAttributes::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::meta::Introspect::<ModelInContract>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::meta::layout::compute_packed_size(ModelInContractAttributes::layout())
        }

        fn layout(self: @ContractState) -> dojo::meta::Layout {
            ModelInContractAttributes::layout()
        }

        fn schema(self: @ContractState) -> dojo::meta::introspect::Ty {
            dojo::meta::Introspect::<ModelInContract>::ty()
        }
    }

    #[abi(embed_v0)]
    impl ModelInContractImpl of IModelInContract<ContractState>{
        fn ensure_abi(self: @ContractState, model: ModelInContract) {
        }
    }
}


#[cfg(target: "test")]
pub impl ModelInContractModelTestImpl of dojo::model::ModelTest<ModelInContract> {
   fn set_test(
        self: @ModelInContract,
        world: dojo::world::IWorldDispatcher
    ) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            ModelInContractAttributes::selector(),
            dojo::model::ModelIndex::Keys(ModelInContractModelStore::keys(self)),
            ModelInContractModelStore::values(self),
            dojo::model::introspect::<ModelInContract>::layout()

        );
    }

    fn delete_test(
        self: @ModelInContract,
        world: dojo::world::IWorldDispatcher
    ) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            ModelInContractAttributes::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::keys(self)),
            dojo::model::introspect::<ModelInContract>::layout()

        );
    }
}

#[cfg(target: "test")]
pub impl ModelInContractModelEntityTestImpl of dojo::model::ModelEntityTest<ModelInContractEntity> {
    fn update_test(self: @ModelInContractEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            ModelInContractAttributes::selector(),
            dojo::model::ModelIndex::Id(ModelInContractEntityStore::id(self)),
            ModelInContractModelEntityImpl::values(self),
            dojo::model::introspect::<ModelInContract>::layout()
        );
    }

    fn delete_test(self: @ModelInContractEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            ModelInContractAttributes::selector(),
            dojo::model::ModelIndex::Id(ModelInContractEntityStore::id(self)),
            dojo::model::introspect::<ModelInContract>::layout()
        );
    }
}