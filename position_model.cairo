
impl PositionIntrospect<> of dojo::meta::introspect::Introspect<Position<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(2)
    }

    fn layout() -> dojo::meta::Layout {
        dojo::meta::Layout::Struct(
            array![
            dojo::meta::FieldLayout {
                    selector: 512066735765477566404754172672287371265995314501343422459174036873487219331,
                    layout: dojo::meta::introspect::Introspect::<u32>::layout()
                },
dojo::meta::FieldLayout {
                    selector: 1591024729085637502504777720563487898377940395575083379770417352976841400819,
                    layout: dojo::meta::introspect::Introspect::<u32>::layout()
                }
            ].span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'Position',
                attrs: array![].span(),
                children: array![
                dojo::meta::introspect::Member {
            name: 'player',
            attrs: array!['key'].span(),
            ty: dojo::meta::introspect::Introspect::<ContractAddress>::ty()
        },
dojo::meta::introspect::Member {
            name: 'x',
            attrs: array![].span(),
            ty: dojo::meta::introspect::Introspect::<u32>::ty()
        },
dojo::meta::introspect::Member {
            name: 'y',
            attrs: array![].span(),
            ty: dojo::meta::introspect::Introspect::<u32>::ty()
        }

                ].span()
            }
        )
    }
}
        #[derive(Drop, Serde)]
pub struct PositionEntity {
    __id: felt252, // private field
    pub x: u32,
pub y: u32,

} 

type PositionKeyType = ContractAddress;

pub impl PositionModelKeyImpl of dojo::model::members::key::KeyParserTrait<Position, PositionKeyType>{
    fn _key(self: @Position) -> PositionKeyType {
        *self.player
    }
} 

pub impl PositionKeyImpl = dojo::model::members::key::KeyImpl<PositionKeyType>;

// Impl to get the static attributes of a model
mod position_attributes {
    use super::Position;
    pub impl PositionAttributesImpl<T> of dojo::model::ModelAttributes<T>{
    
        #[inline(always)]
        fn version() -> u8 {
            1
        }
       
        #[inline(always)]
        fn selector() -> felt252 {
            1296822374913880379052045622268939498018036308099740331443344741174969641567
        }
        
        #[inline(always)]
        fn name_hash() -> felt252 {
            2899920299641094436341712346886623904698864491830316325765258522168980161362
        }
    
        #[inline(always)]
        fn namespace_hash() -> felt252 {
            2676555803512978187621970457973650611834707214703290319164728220764632594214
        }
    
        #[inline(always)]
        fn name() -> ByteArray {
            "Position"
        }
        
        #[inline(always)]
        fn namespace() -> ByteArray {
            "ds"
        }
        
        #[inline(always)]
        fn tag() -> ByteArray {
            "ds-Position"
        }
    
        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Introspect::<Position>::layout()
        }
    }
    
}


pub impl PositionAttributes = position_attributes::PositionAttributesImpl<Position>;
pub impl PositionEntityAttributes = position_attributes::PositionAttributesImpl<PositionEntity>;

pub impl PositionModelSerdeImpl of dojo::model::model::ModelSerde<Position>{
    fn _keys(self: @Position) -> Span<felt252> {
        dojo::model::members::MemberTrait::<PositionKeyType>::serialize(
            @PositionModelKeyImpl::_key(self)
        )
    }
    fn _values(self: @Position) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.x, ref serialized);
core::serde::Serde::serialize(self.y, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn _keys_values(self: @Position) -> (Span<felt252>, Span<felt252>) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.x, ref serialized);
core::serde::Serde::serialize(self.y, ref serialized);

        (Self::_keys(self), core::array::ArrayTrait::span(@serialized))
    }
}

pub impl PositionEntitySerdeImpl of dojo::model::entity::EntitySerde<PositionEntity>{
    fn _id(self: @PositionEntity) -> felt252 {
        *self.__id
    }
    fn _values(self: @PositionEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.x, ref serialized);
core::serde::Serde::serialize(self.y, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn _id_values(self: @PositionEntity) -> (felt252, Span<felt252>) {
        (*self.__id, Self::_values(self))
    }
}


// pub impl PositionModelImpl = dojo::model::model::Model<Position>;
// pub impl PositionStore = dojo::model::model::ModelStoreImpl<Position, PositionKeyType>;

// pub impl PositionEntityImpl = dojo::model::entity::Entity<PositionEntity>;
// pub impl PositionEntityStore = dojo::model::entity::EntityStoreImpl<PositionEntity>;


//////


#[starknet::interface]
pub trait IPosition<T> {
    fn ensure_abi(self: @T, model: Position);
}

#[starknet::contract]
pub mod position {
    use super::Position;
    use super::IPosition;
    use super::PositionAttributes;
    use super::PositionModelImpl;
    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState>{
        fn name(self: @ContractState) -> ByteArray {
            PositionAttributes::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            PositionAttributes::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            PositionAttributes::tag()
        }

        fn version(self: @ContractState) -> u8 {
            PositionAttributes::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            PositionAttributes::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            PositionAttributes::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            PositionAttributes::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::meta::Introspect::<Position>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::meta::layout::compute_packed_size(PositionAttributes::layout())
        }

        fn layout(self: @ContractState) -> dojo::meta::Layout {
            PositionAttributes::layout()
        }

        fn schema(self: @ContractState) -> dojo::meta::introspect::Ty {
            dojo::meta::Introspect::<Position>::ty()
        }
    }

    #[abi(embed_v0)]
    impl PositionImpl of IPosition<ContractState>{
        fn ensure_abi(self: @ContractState, model: Position) {
        }
    }
}


#[cfg(target: "test")]
pub impl PositionModelTestImpl of dojo::model::ModelTest<Position> {
   fn set_test(
        self: @Position,
        world: dojo::world::IWorldDispatcher
    ) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            PositionAttributes::selector(),
            dojo::model::ModelIndex::Keys(PositionModelStore::keys(self)),
            PositionModelStore::values(self),
            dojo::model::introspect::<Position>::layout()

        );
    }

    fn delete_test(
        self: @Position,
        world: dojo::world::IWorldDispatcher
    ) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            PositionAttributes::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::keys(self)),
            dojo::model::introspect::<Position>::layout()

        );
    }
}

#[cfg(target: "test")]
pub impl PositionModelEntityTestImpl of dojo::model::ModelEntityTest<PositionEntity> {
    fn update_test(self: @PositionEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            PositionAttributes::selector(),
            dojo::model::ModelIndex::Id(PositionEntityStore::id(self)),
            PositionModelEntityImpl::values(self),
            dojo::model::introspect::<Position>::layout()
        );
    }

    fn delete_test(self: @PositionEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher { contract_address: 
             world.contract_address };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            PositionAttributes::selector(),
            dojo::model::ModelIndex::Id(PositionEntityStore::id(self)),
            dojo::model::introspect::<Position>::layout()
        );
    }
}