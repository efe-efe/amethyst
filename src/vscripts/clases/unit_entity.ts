type UnitEntityOptions =
    | {
          unit: CDOTA_BaseNPC;
      }
    | {
          properties: {
              origin: Vector;
              name: string;
              team?: DotaTeam;
          };
      };

export default class UnitEntity {
    origin: Vector;
    team: DotaTeam;
    name: string;
    destroyed = false;
    unit: CDOTA_BaseNPC;

    constructor(options: UnitEntityOptions) {
        this.team = "unit" in options ? options.unit.GetTeam() : this.InitializeTeam(options.properties.team);
        this.origin = "unit" in options ? options.unit.GetAbsOrigin() : options.properties.origin;
        this.name = "unit" in options ? options.unit.GetName() : options.properties.name;
        this.unit =
            "unit" in options
                ? this.SetUnit(options.unit)
                : this.SetUnit(CreateUnitByName(this.name, this.origin, true, undefined, undefined, this.team));

        if ("properties" in options) {
            this.unit.SetAbsOrigin(this.origin);
        }
        ListenToGameEvent("entity_killed", event => this.OnUnitDied(event), undefined);
    }

    InitializeTeam(team: DotaTeam | undefined): DotaTeam {
        return team ? team : DotaTeam.NOTEAM;
    }

    SetUnit(unit: CDOTA_BaseNPC): CDOTA_BaseNPC {
        CustomEntitiesLegacy.SetParent(unit, this);
        return unit;
    }

    GetUnit(): CDOTA_BaseNPC {
        return this.unit;
    }

    Alive(): boolean {
        return !this.destroyed;
    }

    Destroy(remove: boolean): void {
        this.destroyed = true;

        if (remove) {
            GameRules.Addon.RemoveUnit(this.unit);
            UTIL_Remove(this.unit);
        }
    }

    OnUnitDied(event: EntityKilledEvent): void {
        const killed = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;
        if (killed === this.unit) {
            this.OnDeath(event);
        }
    }

    OnDeath(event: EntityKilledEvent): void {
        //override this method
    }
}
