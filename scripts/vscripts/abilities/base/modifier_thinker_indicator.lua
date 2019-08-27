modifier_thinker_indicator = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_thinker_indicator:OnCreated( kv )
    if IsServer() then
        local thinker = kv.thinker

        self.show_all = kv.show_all
        self.radius = kv.radius
        self.delay_time = kv.delay_time
        self.caster = self:GetCaster()
        self.origin = self:GetParent():GetOrigin()

        CreateModifierThinker(
            self.caster, --hCaster
            self:GetAbility(), --hAbility
            thinker, --modifierName
            {}, --paramTable
            self.origin, --vOrigin
            self.caster:GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
        )

        self:PlayEffects()
        -- Start Interval
        self:StartIntervalThink( self.delay_time )
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_thinker_indicator:OnDestroy()
    if IsServer() then
	    self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- On Think
function modifier_thinker_indicator:OnIntervalThink()
    if IsServer() then
	    self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function modifier_thinker_indicator:PlayEffects()
    local particle_cast_aoe = "particles/ui_mouseactions/range_finder_aoe.vpcf"
    
    if self.show_all == 1 then
        self.effect_cast_aoe = ParticleManager:CreateParticle( particle_cast_aoe, PATTACH_WORLDORIGIN, self.parent)
        ParticleManager:SetParticleControl( self.effect_cast_aoe, 3, Vector(self.radius, 0, 0))
	else
        self.effect_cast_aoe = ParticleManager:CreateParticleForPlayer( particle_cast_aoe, PATTACH_WORLDORIGIN, self.parent, parent_owner )
        ParticleManager:SetParticleControl( self.effect_cast_aoe, 3, Vector(self.radius, 0, 0))
    end

    ParticleManager:SetParticleControl( self.effect_cast_aoe, 0, Vector(self.origin.x, self.origin.y, 128))	-- line origin
    ParticleManager:SetParticleControl( self.effect_cast_aoe, 2, Vector(self.origin.x, self.origin.y, 128))	-- line origin
end

function modifier_thinker_indicator:StopEffects()
	if self.effect_cast_aoe ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast_aoe, false ) 
		ParticleManager:ReleaseParticleIndex( self.effect_cast_aoe )
	end
end