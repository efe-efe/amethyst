modifier_following_aoe_indicator = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_following_aoe_indicator:OnCreated( kv )
    if IsServer() then
        self.show_all = kv.show_all
        self.radius = kv.radius
        self.rate = kv.rate

        if kv.rate then
            self:StartIntervalThink( kv.rate )
        else
            self:StartIntervalThink( 0.5 )
        end
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_following_aoe_indicator:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- On Think
function modifier_following_aoe_indicator:OnIntervalThink()
    if IsServer() then
        CreateRadiusMarker(self:GetCaster(), self:GetParent(), {
            show_all = self.show_all,
            radius = self.radius
        })
	end
end
