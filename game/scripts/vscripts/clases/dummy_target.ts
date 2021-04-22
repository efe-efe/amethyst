import UnitEntity from './unit_entity';

export default class DummyTarget extends UnitEntity{
    constructor(origin: Vector){
        super(origin, 'npc_dota_creature_dummy_target');
    }

    OnDeath(): void{
        this.Destroy(false);
    }
}