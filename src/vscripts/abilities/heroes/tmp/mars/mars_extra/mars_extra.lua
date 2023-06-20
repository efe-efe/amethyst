mars_extra = class({})
mars_extra_recast = class({})
LinkLuaModifier("modifier_mars_extra_recast", "abilities/heroes/mars/mars_extra/modifier_mars_extra_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_soldier", "abilities/heroes/mars/modifier_mars_soldier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_soldier_debuff", "abilities/heroes/mars/modifier_mars_soldier_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_soldier_displacement", "abilities/heroes/mars/modifier_mars_soldier_displacement", LUA_MODIFIER_MOTION_BOTH)

GetAnimation(){		return GameActivity.DOTA_GENERIC_CHANNEL_1 }
GetPlaybackRateOverride(){    return 2.0 }
GetCastingCrawl(){ 			return 10 }

OnSpellStart(){
	
	const origin = this.caster.GetAbsOrigin()
    const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), undefined)
	const direction = (origin - point):Normalized()
	const duration = 5.0
	const radius = this.GetSpecialValueFor('radius')

	const spawnPoint = point + (direction * radius * -1)

	const callback = function(unit)
		CustomEntitiesLegacy:FullyFaceTowards(unit, direction)
		unit:SetNeverMoveToClearSpace(true)
		unit:AddNewModifier(
			this.caster, -- player source
			this, -- ability source
			"modifier_mars_soldier", -- modifier name
			{
				duration = duration,
				model = 1,
				fade = 0,
				marker = 1,
				x = direction.x,
				y = direction.y,
				radius = radius,
			} -- kv
		)
		
		unit:SetModelScale(1.3)
		
		EFX("particles/mars/mars_extra.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
			cp1 = unit:GetAbsOrigin(),
			release = true
		})

		EFX("particles/units/heroes/hero_invoker_kid/invoker_kid_forge_spirit_ambient.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
			release = true
		})

		EFX("particles/items_fx/aegis_respawn_aegis_trail.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, unit, {
			release = true
		})
		
		unit:StartGesture(GameActivity.DOTA_SPAWN)
		EmitSoundOn('Hero_Mars.Spear.Root', unit)
	}

	const unit = CreateUnitByNameAsync(
		"npc_dota_mars_ultimate_soldier",
		spawnPoint,
		false,
		this.caster,
		undefined,
		this.caster.GetTeamNumber(),
		callback
	)

	if(this.GetName() == 'mars_extra' ) {
		if(this.GetLevel() == 2 ) {
			this.caster.AddNewModifier(this.caster, this, "modifier_mars_extra_recast", { duration = 1.5 })
		}
	}
}

mars_extra_recast.GetCastAnimationCustom =	mars_extra.GetCastAnimationCustom
mars_extra_recast.GetPlaybackRateOverride = mars_extra.GetPlaybackRateOverride
mars_extra_recast.GetCastPointSpeed = mars_extra.GetCastPointSpeed
mars_extra_recast.OnSpellStart = mars_extra.OnSpellStart

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(mars_extra)
Abilities.Castpoint(mars_extra_recast)