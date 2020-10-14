import server from './server';

export default class HeroController{
    static StartMoving(direction: number[]): void{
        server.sendStartMovementSignalToServer(direction);
    }

    static StopMoving(direction: number[]): void{
        server.sendStopMovementSignalToServer(direction);
    }

    static Cancel(): void{
        const playerId = Players.GetLocalPlayer();
        const heroIndex = Players.GetPlayerHeroEntityIndex(playerId);

        const order = {
            OrderType : dotaunitorder_t.DOTA_UNIT_ORDER_STOP,
            TargetIndex : heroIndex,
            ShowEffects : false,
            QueueBehavior : OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
        };
        Game.PrepareUnitOrders(order);
    }

    static StopCastAbility(slotIndex: number): void{
        const playerId = Players.GetLocalPlayer();
        const heroIndex = Players.GetPlayerHeroEntityIndex(playerId);
        const abilityEntityIndex = Entities.GetAbility(heroIndex, slotIndex);
        server.sendStopAbilitySignalToServer(abilityEntityIndex);
    }
    
    static CastAbility(slotIndex: number, showEffects = true): void{
        const playerId = Players.GetLocalPlayer();
        const heroIndex = Players.GetPlayerHeroEntityIndex(playerId);
        const abilityEntityIndex = Entities.GetAbility(heroIndex, slotIndex);

        if(!Abilities.IsInAbilityPhase(abilityEntityIndex)){
            const mousePositionScreen = GameUI.GetCursorPosition();
            const mousePosition = Game.ScreenXYToWorld(mousePositionScreen[0], mousePositionScreen[1]);
    
            const abilityBehavior = Abilities.GetBehavior(abilityEntityIndex);
            if(abilityBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_POINT){
                const order = {
                    OrderType : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_POSITION,
                    TargetIndex : heroIndex,
                    Position : mousePosition,
                    QueueBehavior : OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
                    ShowEffects : showEffects,
                    AbilityIndex : abilityEntityIndex,
                };
                Game.PrepareUnitOrders(order);
            }
            if(abilityBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_NO_TARGET){
                const order = {
                    OrderType : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_NO_TARGET,
                    TargetIndex : heroIndex,
                    Position : mousePosition,
                    QueueBehavior : OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
                    ShowEffects : showEffects,
                    AbilityIndex : abilityEntityIndex,
                };
                Game.PrepareUnitOrders(order);
            }
        }
    }
}