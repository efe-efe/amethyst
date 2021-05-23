import { HeroData } from './types';
import { tables } from './util';

type GenericData = {
    key: string | number | symbol;
    value: never;
}

export default class CustomEntities{
    private static instance: CustomEntities;
    private onUpdateCallbacks: any[] = [];
    private entities: HeroData[] = [];
        
    private constructor(){
        const tableName = 'heroes' as never;
        tables.subscribeToNetTableAndLoadNow(tableName, (table: never, key: string | number | symbol, value: any) => {
            const entity = value as HeroData;
            this.SetEntity(entity);
        });
    }
    
    public static GetInstance(): CustomEntities {
        if (!CustomEntities.instance) {
            CustomEntities.instance = new CustomEntities();
        }

        return CustomEntities.instance;
    }

    public SetEntity(entity: HeroData): void{
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

    public GetEntity(entityIndex: EntityIndex): HeroData | undefined{
        return this.entities.filter(entity => entity.entityIndex === entityIndex)[0];
    }

    public UpdateEntity(index: number, entity: HeroData): void{
        this.entities = [
            ...this.entities.slice(0, index),
            ...this.entities.slice(index + 1)
        ];
        this.entities.push(entity);
    }

    public OnReload(): void{
        const tableName = 'heroes' as never;
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