use dojo::{
    meta::{Layout}, model::{ModelAttributes, attributes::ModelIndex},
    world::{IWorldDispatcher, IWorldDispatcherTrait},
    utils::{serialize_inline, deserialize_unwrap, TypeLink, entity_id_from_key}
};


pub trait Values<V> {
    fn serialize(self: @V) -> Span<felt252>;
    fn deserialize(values: Span<felt252>) -> V;

    fn name() -> ByteArray;
    fn namespace() -> ByteArray;
    fn tag() -> ByteArray;
    fn version() -> u8;
    fn selector() -> felt252;
    fn layout() -> Layout;
    fn name_hash() -> felt252;
    fn namespace_hash() -> felt252;
    fn instance_selector(self: @V) -> felt252;
    fn instance_layout(self: @V) -> Layout;
}

pub trait ValuesStore<V> {
    // Get an values from the world
    fn get_values<K, +Drop<K>, +Serde<K>, +TypeLink<V, K>>(self: @IWorldDispatcher, key: K) -> V;
    // Gets the values from the world using its entity id
    fn get_values_from_id(self: @IWorldDispatcher, entity_id: felt252) -> V;
    // Get values from the world using its entity id
    fn update_values<K, +Drop<K>, +Serde<K>, +TypeLink<V, K>>(
        self: IWorldDispatcher, key: K, values: @V
    );
    // Update values in the world using its entity id
    fn update_values_from_id(self: IWorldDispatcher, entity_id: felt252, values: @V);
}

pub impl ValuesImpl<V, +Serde<V>, +ModelAttributes<V>> of Values<V> {
    fn serialize(self: @V) -> Span<felt252> {
        serialize_inline(self)
    }
    fn deserialize(values: Span<felt252>) -> V {
        deserialize_unwrap(values)
    }
    fn name() -> ByteArray {
        ModelAttributes::<V>::name()
    }
    fn namespace() -> ByteArray {
        ModelAttributes::<V>::namespace()
    }
    fn tag() -> ByteArray {
        ModelAttributes::<V>::tag()
    }
    fn version() -> u8 {
        ModelAttributes::<V>::version()
    }
    fn selector() -> felt252 {
        ModelAttributes::<V>::selector()
    }
    fn layout() -> Layout {
        ModelAttributes::<V>::layout()
    }
    fn name_hash() -> felt252 {
        ModelAttributes::<V>::name_hash()
    }
    fn namespace_hash() -> felt252 {
        ModelAttributes::<V>::namespace_hash()
    }
    fn instance_selector(self: @V) -> felt252 {
        ModelAttributes::<V>::selector()
    }
    fn instance_layout(self: @V) -> Layout {
        ModelAttributes::<V>::layout()
    }
}

pub impl ValuesStoreImpl<V, +Values<V>, +Serde<V>, +Drop<V>> of ValuesStore<V> {
    fn get_values<K, +Drop<K>, +Serde<K>, +TypeLink<V, K>>(self: @IWorldDispatcher, key: K) -> V {
        Self::get_values_from_id(self, entity_id_from_key(@key))
    }

    fn get_values_from_id(self: @IWorldDispatcher, entity_id: felt252) -> V {
        let values = IWorldDispatcherTrait::entity(
            *self, Values::<V>::selector(), ModelIndex::Id(entity_id), Values::<V>::layout()
        );
        Values::<V>::deserialize(values)
    }

    fn update_values<K, +Drop<K>, +Serde<K>, +TypeLink<V, K>>(
        self: IWorldDispatcher, key: K, values: @V
    ) {
        Self::update_values_from_id(self, entity_id_from_key(@key), values)
    }

    fn update_values_from_id(self: IWorldDispatcher, entity_id: felt252, values: @V) {
        IWorldDispatcherTrait::set_entity(
            self,
            Values::<V>::selector(),
            ModelIndex::Id(entity_id),
            serialize_inline(values),
            Values::<V>::layout()
        );
    }
}
