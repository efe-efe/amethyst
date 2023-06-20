modifier_nevermore_extra = class({})

IsAura(){
	return true
}
GetModifierAura(){
	return "modifier_nevermore_extra_debuff"
}
GetAuraRadius(){
	return this.radius
}
GetAuraDuration(){
	return 0.5
}
GetAuraSearchTeam(){
	return DOTA_UNIT_TARGET_TEAM_BOTH
}
GetAuraEntityReject(entity: CDOTA_BaseNPC){
    if(CustomEntitiesLegacy:Allies(this.caster, entity) ) {
        return true 
    }
    return false
}
GetAuraSearchType(){
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
}

OnCreated(params){
    this.radius = this.ability.GetSpecialValueFor("radius")
    if(IsServer() ) {
        this.SetStackCount(params.souls)
        
        const origin = this.caster.GetAbsOrigin()

        this.efx = EFX('particles/nevermore/nevermore_ex_second_attack.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            cp2 = Vector(this.radius, 0, 0)
        })
    
        ParticleManager.SetParticleControlEnt(
            this.efx, 
            1, 
            this.caster, 
            ParticleAttachment.POINT_FOLLOW, 
            "attach_hitloc", 
            origin, 
            true
        )
    }
}

OnDestroy(){
    if(IsServer() ) {
        ParticleManager.DestroyParticle(this.efx, false)
        ParticleManager.ReleaseParticleIndex(this.efx)
    }
}

function modifier_nevermore_extra:GetStatusLabel() return "Tornado" }
function modifier_nevermore_extra:GetStatusPriority() return 4 }
function modifier_nevermore_extra:GetStatusStyle() return "Tornado" }

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Status(modifier_nevermore_extra)