export default class UnitEntity{
    origin: Vector;
    team: DotaTeam;
    destroyed = false;
    unit: CDOTA_BaseNPC;

    constructor(origin: Vector, name: string, team = DotaTeam.NOTEAM){
        this.origin = origin;
        this.team = team;

        this.SetUnit(CreateUnitByName(
            name,
            this.origin,
            true,
            undefined,
            undefined,
            this.team
        ));
        
        this.GetUnit().SetAbsOrigin(this.origin);
    }

    SetUnit(unit: CDOTA_BaseNPC): void{
        this.unit = unit;
        CustomEntities.SetParent(this.unit, this);
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