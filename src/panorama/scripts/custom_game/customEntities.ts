import { UnitData } from './types';
import { tables } from './util';

type GenericData = {
    key: string | number | symbol;
    value: never;
}

export default class CustomEntities{
    private static instance: CustomEntities;
    private onUpdateCallbacks: any[] = [];
    private entities: UnitData[] = [];
        
    private constructor(){
        const tableName = 'units' as never;
        tables.subscribeToNetTableAndLoadNow(tableName, (table: never, key: string | number | symbol, value: any) => {
            const entity = value as UnitData;
            this.SetEntity(entity);
        });
    }
    
    public static GetInstance(): CustomEntities {
        if (!CustomEntities.instance) {
            CustomEntities.instance = new CustomEntities();
        }

        return CustomEntities.instance;
    }

    public SetEntity(entity: UnitData): void{
        const index = this.GetEntityArrayIndex(entity.entityIndex);
        if(index !== undefined){
            this.UpdateEntity(index, entity);
        } else {
            this.entities.push(entity);
        }


        this.onUpdateCallbacks.forEach(callback => {
            callback(entity);
        });
    }

    public GetEntity(entityIndex: EntityIndex): UnitData | undefined{
        return this.entities.filter(entity => entity.entityIndex === entityIndex)[0];
    }

    public UpdateEntity(index: number, entity: UnitData): void{
        this.entities = [
            ...this.entities.slice(0, index),
            ...this.entities.slice(index + 1)
        ];
        this.entities.push(entity);
    }

    public OnReload(): void{
        const tableName = 'units' as never;
        const data = CustomNetTables.GetAllTableValues(tableName);
        
        data.forEach((d) => {
            const parsedD = d  as GenericData;
            this.SetEntity(parsedD.value);
        });
    }


    public AddCallback(callback: any): void{
        this.onUpdateCallbacks.push(callback);
    }

    public GetEntityArrayIndex(entityIndex: EntityIndex): number | undefined {
        let index = undefined;
        this.entities.forEach((entity, i) => {
            if(entity.entityIndex === entityIndex){
                index = i;
            }
        });

        return index;
    }

    public IsBeingSelectedByLocal(entityIndex: EntityIndex): boolean {
        const localPlayerId = Game.GetLocalPlayerID();
        const selectedEntity = Players.GetSelectedEntities(localPlayerId)[0];

        return selectedEntity === entityIndex;
    }
}