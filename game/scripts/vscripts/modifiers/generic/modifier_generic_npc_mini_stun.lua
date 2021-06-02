modifier_generic_npc_mini_stun = class({})

function modifier_generic_npc_mini_stun:OnHit(params)
	if IsServer() then
		if not params.bTriggerCounters then
			return true
		end

        local hSource = nil
		if params.iType == MEELE_HIT then
            hSource = params.hSource
        end
        
        if hSource then
            if not self:GetParent():HasModifier("modifier_generic_npc_shield") then
                self:GetParent():AddNewModifier(
                    hSource,
                    nil,
                    "modifier_generic_stunned",
                    {
                        duration = 0.25,
                    }
                )
            end
            --[[
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
            ]]
        end
		
		return true
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnHit(modifier_generic_npc_mini_stun)