modifier_counter = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_counter:IsHidden()
	return false
end

function modifier_counter:IsDebuff()
	return false
end

function modifier_counter:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_counter:OnCreated( kv )
    if IsServer() then
        self.movement_speed = kv.movement_speed
        self.can_walk = kv.can_walk
        self.sound = kv.sound
        self.can_be_cancelled = kv.can_be_cancelled
        self.disable = kv.disable

        self.mobility = kv.mobility
        self.counter = kv.counter
        self.ultimate = kv.ultimate
        self.ex_two = kv.ex_two
        
        self.destroy_on_trigger = kv.destroy_on_trigger
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()

        if kv.activity ~= nil then
            local rate = 1.0
            if kv.rate ~= nil then
                rate = kv.rate
            end

            StartAnimation(self.caster, { 
                duration = self:GetDuration() + 0.1, 
                activity = kv.activity, 
                rate = rate
            })
        end

        if self.sound ~= nil then 
            EmitSoundOn(self.sound, self.caster)
        end

        if self.disable ~= 0 then
            self:DisableSpells( false )
        end

        if self.ability.OnStartCounter ~= nil then
            self.ability:OnStartCounter()
        end

        self:PlayEffectsAura()
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_counter:OnDestroy( kv )
    if IsServer() then
        
        if self.disable ~= 0 then
            self:DisableSpells( true )
        end
        
        if self.sound ~= nil then 
            StopSoundOn(self.sound, self.caster)
        end

        if self.ability.OnEndCounter ~= nil then
            self.ability:OnEndCounter()
        end

        self:StopEffectsAura()
    end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_counter:CheckState()
    if self.can_walk == 0 then
        return { [MODIFIER_STATE_ROOTED] = true }
    else
        return {}
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ORDER,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_counter:GetModifierMoveSpeedBonus_Percentage()
	if self.movement_speed ~= nil then
		return - (100 - self.movement_speed)
	end
end

function modifier_counter:OnOrder(params)
    if params.unit == self.caster then
        if 	params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
            if self.can_be_cancelled ~= 0 then
                self:Destroy()
            end
        end
    end
end


function modifier_counter:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
        -- Pure damage doesnt trigger the counter
        if params.damage_type ~= DAMAGE_TYPE_PURE then
            self.ability:OnTrigger( params )
            self:StrongPurge()
            if self.destroy_on_trigger == 1 then
                self:Destroy()
            end
            return -100
        end
        return 0
	end
end

function modifier_counter:OnAbilityFullyCast( params )
	if IsServer() then
		if params.unit ~= self.caster then
			return
        end
        if params.ability ~= self.ability then
            self:Destroy()
        end
	end
end

--------------------------------------------------------------------------------
-- Helpers
function modifier_counter:StrongPurge()
    local RemovePositiveBuffs = false
    local RemoveDebuffs = true
    local BuffsCreatedThisFrameOnly = false
    local RemoveStuns = true
    local RemoveExceptions = false

    -- Apply dispell after debuffs and stuns are applied
    Timers:CreateTimer(0.001, function()
        self.caster:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
    end)
end


function modifier_counter:DisableSpells( mode )
	if IsServer() then
        for i = 0, 12 do
            local ability = self.caster:GetAbilityByIndex(i)
            if ability then
                if ability:GetAbilityType() ~= 2 then -- To not level up the talents
                    if ability ~= self:GetAbility() then
                        if self:DisableTest(i) == true then
                            ability:SetActivated( mode  )
                        end 
                    end
                end
            end
		end
	end
end

function modifier_counter:DisableTest(index)
    if      index == 0 then
        if self.counter ~= 1 then
            return true
        end
    elseif  index == 1 then
        if self.basic_attack ~= 1 then
            return true
        end
    elseif  index == 2 then
        if self.special_attack ~= 1 then
            return true
        end
    elseif  index == 3 then
        if self.second_attack ~= 1 then
            return true
        end
    elseif  index == 4 then
        if self.ex_ultimate ~= 1 then
            return true
        end
    elseif  index == 5 then
        if self.ultimate ~= 1 then
            return true
        end
    elseif  index == 6 then
        if self.mobility ~= 1 then
            return true
        end
    elseif  index == 7 then
        if self.ex_one ~= 1 then
            return true
        end
    elseif  index == 8 then
        if self.ex_two ~= 1 then
            return true
        end
    elseif  index == 9 then
        if self.ex_three ~= 1 then
            return true
        end
    elseif  index == 10 then
        if self.ex_four ~= 1 then
            return true
        end
    elseif  index == 11 then
        if self.ex_five ~= 1 then
            return true
        end
    elseif  index == 12 then
        if self.ex_six ~= 1 then
            return true
        end
    end

    return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_counter:GetStatusEffectName()
	return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_counter:PlayEffectsAura()
    self.effect_cast = ParticleManager:CreateParticle( "particles/items_fx/black_king_bar_avatar.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
end

function modifier_counter:StopEffectsAura()
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end