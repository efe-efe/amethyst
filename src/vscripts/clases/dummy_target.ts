import UnitEntity from "./unit_entity";

export default class DummyTarget extends UnitEntity {
  constructor(origin: Vector) {
    super({
      properties: {
        origin,
        name: "npc_dota_creature_dummy_target",
      },
    });
  }

  OnDeath(event: EntityKilledEvent): void {
    super.OnDeath(event);
    this.Destroy(false);
  }
}
