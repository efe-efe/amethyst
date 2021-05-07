export interface ExistingEntityOptions {
    unit: CDOTA_BaseNPC;
}
export interface NonExistingEntityOptions {
    properties: {
        origin: Vector;
        name: string; 
        team?: DotaTeam;
    }
}

export type UnitEntityOptions = ExistingEntityOptions | NonExistingEntityOptions;

export default class UnitEntity{
    origin: Vector;
    team: DotaTeam;
    name: string;
    destroyed = false;
    unit: CDOTA_BaseNPC;

    constructor(options: UnitEntityOptions){
        this.team = ((options as ExistingEntityOptions).unit) ? (options as ExistingEntityOptions).unit.GetTeam() : this.InitializeTeam((options as NonExistingEntityOptions).properties.team);
        this.origin = ((options as ExistingEntityOptions).unit) ? (options as ExistingEntityOptions).unit.GetAbsOrigin() : (options as NonExistingEntityOptions).properties.origin;
        this.name = ((options as ExistingEntityOptions).unit) ? (options as ExistingEntityOptions).unit.GetName() : (options as NonExistingEntityOptions).properties.name;
        this.unit = ((options as ExistingEntityOptions).unit) ? this.SetUnit((options as ExistingEntityOptions).unit) : this.SetUnit(CreateUnitByName(
            this.name,
            this.origin,
            true,
            undefined,
            undefined,
            this.team
        ));

        if((options as NonExistingEntityOptions).properties){
            this.unit.SetAbsOrigin(this.origin);
        }
    }

    InitializeTeam(team: DotaTeam | undefined): DotaTeam{
        return (team) ? team : DotaTeam.NOTEAM;
    }

    SetUnit(unit: CDOTA_BaseNPC): CDOTA_BaseNPC{
        CustomEntities.SetParent(unit, this);
        return unit;
    }

    GetUnit(): CDOTA_BaseNPC{
        return this.unit;
    }

    Alive(): boolean{
        return !this.destroyed;
    }

    Destroy(remove: boolean): void{
        this.destroyed = true;

        if(remove){
            UTIL_Remove(this.GetUnit());
        }
    }

    OnDeath(params: { killer: CDOTA_BaseNPC }): void{
        //override this method
    }
}