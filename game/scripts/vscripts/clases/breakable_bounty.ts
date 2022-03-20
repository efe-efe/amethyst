import UnitEntity from './unit_entity';

export interface BreakableBountyOptions {
    model: string;
    particle?: string;
    scale?: number;
    health: number;
}

export default class BreakableBounty extends UnitEntity{
    model: string;
    particle: string | undefined;
    scale: number;

    constructor(origin: Vector, options: BreakableBountyOptions){
        super({ properties: {
            origin, 
            name: 'breakable_bounty'
        }});
        this.particle = (options.particle) ? options.particle : undefined;
        this.model = options.model;
        this.scale = (options.scale) ? options.scale : 1.0;

        const unit = this.GetUnit();
        unit.SetModel(this.model);
        unit.SetModelScale(this.scale);
        unit.SetMaxHealth(options.health);
        unit.SetBaseMaxHealth(options.health);
        unit.SetHealth(options.health);
        CustomEntitiesLegacy.SendDataToClient(unit);
        this.PlayEffectsOnSpawn();
    }

    Update(): void{
        const currentAngle = (GameRules.GetGameTime() % (math.pi * 2)) * 2.0;

        if(!CustomEntitiesLegacy.IsBanished(this.GetUnit()) && this.Alive()){
            CustomEntitiesLegacy.FullyFaceTowards(this.GetUnit(), Vector(math.cos(currentAngle), math.sin(currentAngle)));
            this.GetUnit().SetModel(this.model);
            this.GetUnit().SetModelScale(this.scale);
        }
    }

    OnDeath(event: EntityKilledEvent): void{
        const killer = EntIndexToHScript(event.entindex_attacker) as CDOTA_BaseNPC;

        if(killer === this.unit){
            return;
        }
        
        this.Effect(killer);
        this.PlayEffectsOnDeath();
        this.BeforeRemoving(killer);
        this.GetUnit().AddNoDraw();
        this.Destroy(false);
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    BeforeRemoving(killer: CDOTA_BaseNPC): void{
        //override this method
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    Effect(killer: CDOTA_BaseNPC): void{
        //override this method
    }
    
    PlayEffectsOnSpawn(): void{
        //
    }

    PlayEffectsOnDeath(): void{
        const parent = this.GetUnit();
        const origin = parent.GetAbsOrigin();

        EmitSoundOn('Hero_Magnataur.ReversePolarity.Cast', parent);
        EFX('particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf', ParticleAttachment.WORLDORIGIN, undefined, { 
            cp0: origin,
            cp2: Vector(255, 80, 230),
            release: true 
        });
        EFX('particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf', ParticleAttachment.WORLDORIGIN, undefined, { 
            cp0: origin,
            cp5: origin,
            release: true 
        });
        this.PlaySpecificEffectsOnDeath();
    }

    PlaySpecificEffectsOnDeath(){
        //override this method
    }
}
