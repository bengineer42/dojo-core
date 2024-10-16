#[starknet::contract]
pub mod sn_actions {
    #[storage]
    struct Storage {}
}

#[derive(Introspect, Drop, Serde)]
#[dojo_model(namespace: "sn")]
pub struct M {
    #[key]
    pub a: felt252,
    pub b: felt252,
}

#[dojo_contract(namespace: "sn")]
pub mod c1 {
}

#[derive(Introspect, Drop, Serde)]
#[dojo_event(namespace: "sn")]
pub struct MyEvent {
    #[key]
    pub a: felt252,
    pub b: felt252,
}

#[cfg(test)]
mod tests {
    use dojo::utils::snf_test::{spawn_test_world, TestResource, WorldTestExt};

    use super::{MyEvent, MyEventEmitter};

    #[test]
    fn dojo_event_emit() {
        let resources: Span<TestResource> = [
            TestResource::Event("my_event"),
        ].span();

        let world = spawn_test_world(["sn"].span(), resources);

        let e1 = MyEvent { a: 1, b: 2 };
        e1.emit(world);

        let _e1_address = world.resource_contract_address("sn", "MyEvent");
    }
}
