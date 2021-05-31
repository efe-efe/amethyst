import UnitEntity from '../unit_entity';
import Math from '../../util/math';
import customEntities from '../../util/custom_entities';
import { Upgrade, UpgradeTypes } from '../../upgrades/common';
import { UpgradeManager } from '../../upgrades/upgrades';
import { Reward, RewardsManager } from '../../rewards/rewards';
import { CustomEvents } from '../../custom_events';

const DEBUG = false;

enum CollisionTypes {
    SUCCESS = 0,
    UNIT,
    WALL,
    TREE,
}

enum Orientations {
    NONE = 0,
    DIAGONAL_LEFT,
    DIAGONAL_RIGHT,
    HORIZONTAL,
    VERTICAL,
}

interface HeroUpgrade extends Upgrade{
    level: number;
}
export default class CustomNPC extends UnitEntity{
    constructor(unit: CDOTA_BaseNPC){
        CustomEntitiesLegacy.Initialize(unit, !unit.IsRealHero()); //Need this for SetParent bullshit
        super({ unit });
        customEntities.Disarm(this.unit);
        customEntities.IgnoreMSLimit(this.unit);
    }
    LevelAllAbilities(level: number): void{
        for(let i = 0; i <= 23; i++){
            const ability = this.unit.GetAbilityByIndex(i);
            if(ability){
                if(CustomAbilitiesLegacy.IsNotTalentNorAttribute(ability)){
                    ability.SetLevel(level);
                }
            }
        }
    }
    Move(direction: Vector, speed: number): CollisionTypes{
        const offset = 70;
        const origin = this.unit.GetAbsOrigin();
        const futureOrigin = origin.__add(direction.__mul(speed));
        const testOrigin = futureOrigin.__add(direction.__mul(offset));
        futureOrigin.z = GetGroundPosition(futureOrigin, this.unit).z;
        const normal = CustomEntitiesLegacy.GetNormal(this.unit, futureOrigin);

        if(IsInToolsMode() && DEBUG){
            DebugDrawLine_vCol(futureOrigin, testOrigin, Vector(255,0,0), true, 1.0);
            DebugDrawLine_vCol(futureOrigin, futureOrigin.__add(normal.__mul(200)), Vector(255,255,255), true, 1);
            DebugDrawCircle(futureOrigin, Vector(255,0,0), 5, offset, false, 0.03);
        }

        if(this.unit.HasModifier('modifier_spectre_special_attack_buff')){
            this.unit.SetAbsOrigin(futureOrigin);
            return CollisionTypes.SUCCESS;
        }
        
        const trees = GridNav.GetAllTreesAroundPoint(testOrigin, 5, true);
        
        if(normal.z <= 0.9){
            return CollisionTypes.WALL;
        }
        if(trees.length > 0){
            return CollisionTypes.TREE;
        }

        if(!this.unit.IsPhased()){
            const units = FindUnitsInRadius(
                this.unit.GetTeamNumber(),
                testOrigin,
                undefined,
                5,
                UnitTargetTeam.BOTH,
                UnitTargetType.ALL,
                UnitTargetFlags.NONE,
                FindOrder.ANY,
                false
            );

            for(let i = 0; i < units.length; i++){
                const unit = units[i];
                if(unit !== this.unit){
                    if(!unit.IsPhased()){
                        return CollisionTypes.UNIT;
                    }
                }
            }
        }

        if(!CustomEntitiesLegacy.IsAnimating(this.unit)){
            if(!this.unit.HasModifier('modifier_hero_movement')){
                this.unit.AddNewModifier(this.unit, undefined, 'modifier_hero_movement', {});
            }
        }

        this.unit.SetAbsOrigin(futureOrigin);
        return CollisionTypes.SUCCESS;
    }
    AlternativeDirectionsWalls(direction: Vector): Vector[]{
        const directions: Vector[] = [];
        const collisionDirection = CustomEntitiesLegacy.GetCollisionDirection(this.unit);
        const angle = VectorToAngles(direction).y;

        if(Math.IsNorthEast(angle)){
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                return directions;
            }
            directions.push(Math.NORTH);
            directions.push(Math.EAST);
        } 
        if(Math.IsNorthWest(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.NORTH);
                directions.push(Math.WEST);
                return directions;
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(Math.NORTH);
                directions.push(Math.WEST);
                return directions;
            }
            directions.push(Math.NORTH);
            directions.push(Math.WEST);
        } 
        if(Math.IsSouthEast(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.SOUTH);
                directions.push(Math.EAST);
            }
            if(collisionDirection === Orientations.HORIZONTAL){
                directions.push(Math.EAST);
                directions.push(Math.SOUTH);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(Math.SOUTH);
                directions.push(Math.EAST);
            }
        } 
        if(Math.IsSouthWest(angle)){
            if(collisionDirection === Orientations.HORIZONTAL){
                directions.push(Math.WEST);
                directions.push(Math.SOUTH);
            }
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(Math.SOUTH_WEST);
                directions.push(Math.WEST);
                directions.push(Math.SOUTH);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(Math.SOUTH);
                directions.push(Math.WEST);
            }
        } 
        if(Math.IsEast(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(Math.NORTH_EAST);
                directions.push(Math.NORTH);
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.SOUTH_EAST);
                directions.push(Math.SOUTH);
            }
        }
        if(Math.IsWest(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(Math.SOUTH_EAST);
                directions.push(Math.SOUTH);
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.NORTH_WEST);
                directions.push(Math.NORTH);
            }
            if(collisionDirection === Orientations.HORIZONTAL){
                directions.push(Math.SOUTH);
                directions.push(Math.NORTH);
            }
        } 
        if(Math.IsNorth(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(Math.NORTH_EAST);
                directions.push(Math.EAST);
            }
            if(collisionDirection === Orientations.HORIZONTAL){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.WEST);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(Math.NORTH_WEST);
                directions.push(Math.WEST);
            }
        }
        if(Math.IsSouth(angle)){
            if(collisionDirection === Orientations.HORIZONTAL){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(Math.SOUTH_WEST);
                directions.push(Math.WEST);
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.SOUTH_EAST);
                directions.push(Math.EAST);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(Math.EAST);
            }
        }

        return directions;
    }
    AlternativeDirections(direction: Vector): Vector[]{
        const directions = [];
        const angle = VectorToAngles(direction).y;

        if(Math.IsNorthEast(angle)){
            directions.push(Math.NORTH);
            directions.push(Math.EAST);
        } 
        if(Math.IsNorthWest(angle)){
            directions.push(Math.NORTH);
            directions.push(Math.WEST);
        } 
        if(Math.IsSouthEast(angle)){
            directions.push(Math.SOUTH);
            directions.push(Math.EAST);
        } 
        if(Math.IsSouthWest(angle)){
            directions.push(Math.SOUTH);
            directions.push(Math.WEST);
        } 
        if(Math.IsEast(angle) || Math.IsWest(angle)){
            if(this.unit.GetAbsOrigin().y < 0){
                directions.push(Math.SOUTH);
                directions.push(Math.NORTH);
            }
            
            if(this.unit.GetAbsOrigin().y > 0){
                directions.push(Math.NORTH);
                directions.push(Math.SOUTH);
            }
        } 
        if(Math.IsNorth(angle) || Math.IsSouth(angle)){
            if(this.unit.GetAbsOrigin().x < 0){
                directions.push(Math.WEST);
            }
            if(this.unit.GetAbsOrigin().x > 0){
                directions.push(Math.EAST);
            }
        }
        return directions;
    }
    Update(): void{
        const direction = CustomEntitiesLegacy.GetDirection(this.unit).Normalized();
        const speed = (this.unit.GetIdealSpeed()/25);

        if(CustomEntitiesLegacy.IsAnimating(this.unit)){
            this.unit.RemoveModifierByName('modifier_hero_movement');
            this.unit.RemoveModifierByName('modifier_tower_idle');
        }

        if((direction.x !== 0 || direction.y !== 0) && CustomEntitiesLegacy.CanWalk(this.unit)){
            const output = this.Move(direction, speed);
            if(output !== CollisionTypes.SUCCESS){
                let alternativeDirections: Vector[] = [];
                
                if(output === CollisionTypes.WALL){
                    alternativeDirections = this.AlternativeDirectionsWalls(direction);
                } else {
                    alternativeDirections = this.AlternativeDirections(direction);
                }	

                for(let i = 0; i < alternativeDirections.length; i++){
                    const alternativeDireaction = alternativeDirections[i]; 
                    const newOutput = this.Move(alternativeDireaction, speed * 0.8);
                    if(newOutput === CollisionTypes.SUCCESS){
                        break;
                    }
                }
            }
    
            if(	!this.unit.HasModifier('modifier_casting') && 
                !this.unit.HasModifier('modifier_mars_counter_countering') && 
                !this.unit.HasModifier('modifier_spectre_counter_countering')
            ){ 
                CustomEntitiesLegacy.FullyFaceTowards(this.unit, direction);
            }
        } else {
            if(this.unit.GetUnitName() === 'dire_tower'){
                if(!this.unit.HasModifier('modifier_tower_idle')){
                    this.unit.AddNewModifier(this.unit, undefined, 'modifier_tower_idle', {});
                }
            }
            this.unit.RemoveModifierByName('modifier_hero_movement');
        }

        if(IsInToolsMode() && DEBUG){
            if((this.unit as CDOTA_BaseNPC_Hero).GetPlayerID){
                const player = GameRules.Addon.FindPlayerById((this.unit as CDOTA_BaseNPC_Hero).GetPlayerID());

                if(player){
                    const mouse = player.GetCursorPosition();
                    DebugDrawLine_vCol(this.unit.GetAbsOrigin(), this.unit.GetAbsOrigin().__add(this.unit.GetForwardVector().__mul(500)), Vector(0,0,255), true, 0.03);
                    DebugDrawLine_vCol(this.unit.GetAbsOrigin(), mouse, Vector(0,255,0), true, 0.03);
                }
            }
        }
    }
    OnDeath(params: { killer: CDOTA_BaseNPC }): void{
        super.OnDeath(params);
        this.Destroy(false);
    }
}
export class CustomHeroNPC extends CustomNPC{
    constructor(unit: CDOTA_BaseNPC){
        super(unit);
        customEntities.HideHealthBar(this.unit);
        customEntities.SetUseEnergy(this.unit);
    }
}
export class CustomNonPlayerHeroNPC extends CustomHeroNPC{
    constructor(unit: CDOTA_BaseNPC){
        super(unit);
        this.LevelAllAbilities(1);
    }
}
export class CustomPlayerHeroNPC extends CustomHeroNPC{
    heroUpgrades: HeroUpgrade[] = [];
    reward: Reward | undefined;
    remainingTimeToRemoveMana = 1.0 * 30;

    constructor(unit: CDOTA_BaseNPC){
        super(unit);
        if(GameRules.Addon.IsPVE()){
            this.unit.GetAbilityByIndex(0)?.SetLevel(1);
            this.unit.GetAbilityByIndex(5)?.SetLevel(1);
            this.unit.GetAbilityByIndex(6)?.SetLevel(1);
            (this.unit as CDOTA_BaseNPC_Hero).SetAbilityPoints(2);
            customEntities.ChangeMS(this.unit, 50);
            this.unit.RemoveAbility(this.unit.GetAbilityByIndex(7)!.GetName());
            this.unit.RemoveAbility(this.unit.GetAbilityByIndex(8)!.GetName());

            ListenToGameEvent('dota_player_learned_ability', (event) => this.OnLearnedAbilityEvent(event), undefined);
        } else {
            this.LevelAllAbilities(1);        
            (this.unit as CDOTA_BaseNPC_Hero).SetAbilityPoints(2);    
        }
    }
    
    OnLearnedAbilityEvent(event: DotaPlayerLearnedAbilityEvent): void{
        if(event.PlayerID === this.unit.GetPlayerOwnerID()){
            const ability = this.unit.FindAbilityByName(event.abilityname);
            if(ability){
                if(ability.GetLevel() === 2){
                    ability.SetLevel(1);
                    (this.unit as CDOTA_BaseNPC_Hero).SetAbilityPoints((this.unit as CDOTA_BaseNPC_Hero).GetAbilityPoints() + 1);
                }
            }
        }
    }

    Update(): void{
        super.Update();
        if(this.remainingTimeToRemoveMana > 0){
            this.remainingTimeToRemoveMana--;
        } else if(this.remainingTimeToRemoveMana === 0){
            CustomEntitiesLegacy.SetManaCustom(this.unit, 0, true);
            this.remainingTimeToRemoveMana = -1;
        }

        if(this.unit.IsAlive()){
            this.PickupItems();
        }
    }

    PickupItems(): void{
        const dropItems = Entities.FindAllByClassnameWithin('dota_item_drop', this.unit.GetAbsOrigin(), this.unit.GetHullRadius() * 2.5);
        dropItems.forEach((drop) => {
            const item = (drop as CDOTA_Item_Physical).GetContainedItem();
            const owner = item.GetPurchaser();
            
            //Only pickup items owned by teammates
            if(!owner || (owner && CustomEntitiesLegacy.Allies(this.unit, owner) && this.unit !== owner)){
                this.unit.AddItem(item);
                item.OnSpellStart();

                GameRules.Addon.OnPickedUp(item);
                UTIL_Remove(drop);
            }

        });
    }

    IsRanged(): boolean{
        return ((this.unit as CDOTA_BaseNPC_Hero).GetPrimaryAttribute() === Attributes.AGILITY);
    }

    IsMeele(): boolean{
        return ((this.unit as CDOTA_BaseNPC_Hero).GetPrimaryAttribute() === Attributes.STRENGTH);
    }

    IsSelectingFavor(): boolean{
        const tableName = 'custom_npc_favors' as never;
        const value = CustomNetTables.GetTableValue(tableName, this.unit.GetPlayerOwnerID().toString()) as { playerId: PlayerID; upgrades: Upgrade[] | undefined };
        return (value && (value.upgrades !== undefined));
    }

    IsSelectingReward(): boolean{
        const tableName = 'custom_npc_rewards' as never;
        const value = CustomNetTables.GetTableValue(tableName, this.unit.GetPlayerOwnerID().toString()) as { playerId: PlayerID; rewards: Reward[] | undefined };
        return (value && (value.rewards !== undefined));
    }

    ReleaseAbility(abilityName: string): void{
        //WIP
    }

    ApplyFavor(upgrade: Upgrade | undefined): void{
        if(upgrade && upgrade.modifier){
            const ability = (upgrade.ability) ? this.unit.FindAbilityByName(upgrade.ability) : undefined;
            this.unit.AddNewModifier(this.unit, ability, upgrade.modifier.name, { duration: upgrade.modifier.duration });

            let found = false;
            this.heroUpgrades = this.heroUpgrades.map((heroUpgrade) => {
                if(heroUpgrade.id === upgrade.id){
                    found = true;
                    return {
                        ...heroUpgrade,
                        level: heroUpgrade.level + 1
                    };
                } 
                return heroUpgrade;
            });

            if(!found){
                this.heroUpgrades.push({
                    ...upgrade,
                    level: 1,
                });
            }

            if(upgrade.ingredients){
                upgrade.ingredients.forEach((ingredientId) => {
                    const ingredientUpgrade = this.heroUpgrades.filter((_heroUpgrade) => _heroUpgrade.id === ingredientId)[0];

                    if(ingredientUpgrade){
                        this.unit.RemoveModifierByName(ingredientUpgrade.modifier!.name);
                    }
                });

                EFX('particles/items_fx/item_sheepstick.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.unit, {
                    release: true,
                });
                
                this.unit.AddNewModifier(this.unit, undefined, 'modifier_combine_util', { duration: 1.5 });
                
                EmitSoundOn('DOTA_Item.RepairKit.Target', this.unit);
            }
        }

        if(upgrade && upgrade.effect){
            upgrade.effect(this.unit as CDOTA_BaseNPC_Hero);
        }

        this.ClearTable('custom_npc_favors' as never);
        const customEvents = CustomEvents.GetInstance();
        customEvents.EmitEvent('pve:current_reward_applied', { customNpc: this });
    }


    ApplyTarrasque(): void{
        this.unit.AddNewModifier(this.unit, undefined, 'modifier_upgrade_tarrasque', {});
        const customEvents = CustomEvents.GetInstance();
        customEvents.EmitEvent('pve:current_reward_applied', { customNpc: this });

        EmitSoundOn('Hero_Oracle.FortunesEnd.Target', this.unit);
        EFX('particles/gems/emerald.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.unit, {
            cp3: {
                ent: this.unit,
                point: 'attach_hitloc'
            },
            release: true,
        });
    }

    SelectReward(reward: Reward): void{
        this.reward = reward;
        this.ClearTable('custom_npc_rewards' as never);
        const customEvents = CustomEvents.GetInstance();
        customEvents.EmitEvent('pve:next_reward_selected', { customNpc: this, reward });

        const data = { 
            nextReward: this.reward.name,
        } as never;
        CustomNetTables.SetTableValue('main' as never, 'pve', data);
    }

    ClearTable(name: never): void{
        const data = {
            playerId: this.unit.GetPlayerOwnerID(),
        } as never;
        CustomNetTables.SetTableValue(name, this.unit.GetPlayerOwnerID().toString(), data);
    }

    RequestRewards(): void{
        const rewards = RewardsManager.GenerateRewards(this, { amount: RandomInt(1, 3) });
        
        if(rewards.length === 0){
            print('Skipping rewards selection. No rewards available');
            return;         
        }
        
        const data = {
            playerId: this.unit.GetPlayerOwnerID(),
            rewards,
        } as never;

        const tableName = 'custom_npc_rewards' as never;
        CustomNetTables.SetTableValue(tableName, this.unit.GetPlayerOwnerID().toString(), data);
    }

    RequestFavors(): void{
        const upgrades = UpgradeManager.GenerateFavors(this, 3);
        
        if(upgrades.length === 0){
            print('Skipping favors selection. No rewards available');  
            this.ApplyFavor(undefined);
            return;          
        }

        const data = {
            playerId: this.unit.GetPlayerOwnerID(),
            upgrades,
        } as never;

        const tableName = 'custom_npc_favors' as never;
        CustomNetTables.SetTableValue(tableName, this.unit.GetPlayerOwnerID().toString(), data);
    }

    RequestShards(): void{
        const upgrades = UpgradeManager.GenerateShards(this, 3);
        
        if(upgrades.length === 0){
            print('Skipping shards selection. No rewards available');  
            this.ApplyFavor(undefined);
            return;          
        }

        const data = {
            playerId: this.unit.GetPlayerOwnerID(),
            upgrades
        } as never;

        const tableName = 'custom_npc_favors' as never;
        CustomNetTables.SetTableValue(tableName, this.unit.GetPlayerOwnerID().toString(), data);
    }

    RequestKnowledge(): void{
        const upgrades = UpgradeManager.GenerateKnowledge(this, 3);
        
        if(upgrades.length === 0){
            print('Skipping knowledge selection. No rewards available');  
            this.ApplyFavor(undefined);
            return;          
        }
        
        const data = {
            playerId: this.unit.GetPlayerOwnerID(),
            upgrades,
        } as never;

        const tableName = 'custom_npc_favors' as never;
        CustomNetTables.SetTableValue(tableName, this.unit.GetPlayerOwnerID().toString(), data);
    }

    RequestItems(): void{
        const upgrades = UpgradeManager.GenerateItems(this, RandomInt(4, 6));
        
        if(upgrades.length === 0){
            print('Skipping items selection. No rewards available');  
            this.ApplyFavor(undefined);
            return;          
        }
        
        const data = {
            playerId: this.unit.GetPlayerOwnerID(),
            upgrades,
        } as never;

        const tableName = 'custom_npc_favors' as never;
        CustomNetTables.SetTableValue(tableName, this.unit.GetPlayerOwnerID().toString(), data);
    }

}