modifier_generic_meele_npc = class({})

function modifier_generic_meele_npc:OnHit(params)
	if IsServer() then
		if not params.bTriggerCounters then
			return true
		end

        local hSource = nil
		if params.iType == MEELE_HIT then
            hSource = params.hSource
        end
        
        if hSource then
            local direction = (self:GetParent():GetAbsOrigin() - hSource:GetAbsOrigin()):Normalized()
            local distance = 25

            self:GetParent():AddNewModifier(
                hSource,
                nil,
                "modifier_generic_knockback",
                {
                    x = direction.x,
                    y = direction.y,
                    r = distance,
                    speed = (distance/0.25),
                    peak = 15,
                }
            )
        end
		
		return true
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnHit(modifier_generic_meele_npc)