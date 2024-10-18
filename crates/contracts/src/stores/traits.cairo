

trait EntityStoreTrait<S> {
    fn get_entity(self: @S, selector: felt252, index: ModelIndex, layout: Layout) -> Span<felt252>;
    fn set_entity(self: @S, selector: felt252, index: ModelIndex, value: Span<felt252>, layout: Layout);
    fn delete_entity(self: @S, selector: felt252, index: ModelIndex, layout: Layout);
}


struct WorldStore{
    contract_address: ContractAddress,
    name_space_hash: felt252,
}

