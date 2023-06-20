modifier_vengeful_second_attack = class({})

OnCreated(params){
    if(IsServer() ) {
        this.extra_damage = this.ability.GetSpecialValueFor("extra_damage")
    }
}

DeclareFunctions(){
	return { ModifierFunction.INCOMING_DAMAGE_PERCENTAGE }
}

function modifier_vengeful_second_attack:GetModifierIncomingDamage_Percentage(params)
    if(IsServer() ) {
        if(params.attacker ~= this.caster ) { return 0 }
        if(params.inflictor ) {
            if(params.inflictor:GetName() ~= "vengeful_basic_attack" ) {
                const damage_table = {
                    victim = this.parent,
                    attacker = this.caster,
                    damage = this.extra_damage,
                    damage_type = DamageTypes.PURE,
                }
    
                ApplyDamage(damage_table)
                this.PlayEffectsExplosion()
                this.Destroy()
            }
        }
        return 0
	}
}

function modifier_vengeful_second_attack:PlayEffectsExplosion()
	const efx = ParticleManager.CreateParticle("particles/econ/items/templar_assassin/templar_assassin_butterfly/templar_assassin_trap_explosion_shock_butterfly.vpcf", ParticleAttachment.ABSORIGIN, this.parent)
	ParticleManager.SetParticleControl(efx, 1, this.parent.GetAbsOrigin())
	ParticleManager.ReleaseParticleIndex(efx)
}

function modifier_vengeful_second_attack:GetStatusLabel() return "Revenge" }
function modifier_vengeful_second_attack:GetStatusPriority() return 4 }
function modifier_vengeful_second_attack:GetStatusStyle() return "Revenge" }

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Status(modifier_vengeful_second_attack)