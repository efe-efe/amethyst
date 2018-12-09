function PerformAttack(kv)
	-- DebugPrint("[DOTARITE] Performing an attack")
    local attacker = kv.caster
	local target = kv.target
	
	if attacker:IsRangedAttacker() then
		attacker:PerformAttack (
			target, -- handle hTarget 
			true, -- bool bUseCastAttackOrb, 
			true, -- bool bProcessProcs,
			true, -- bool bSkipCooldown
			false, -- bool bIgnoreInvis
			false, -- bool bUseProjectile
			false, -- bool bFakeAttack
			false -- bool bNeverMiss
		)
		return
	end	

	local ability = kv.ability
	local attacksPerSecond = attacker:GetAttacksPerSecond()
	local attackSpeed = ( 1 / attacksPerSecond )
	local attackAnimationPoint = attacker:GetAttackAnimationPoint()

	ability:StartCooldown(attackSpeed)

	Timers:CreateTimer(attackAnimationPoint, function()
        attacker:PerformAttack (
			target, -- handle hTarget 
			true, -- bool bUseCastAttackOrb, 
			true, -- bool bProcessProcs,
			true, -- bool bSkipCooldown
			false, -- bool bIgnoreInvis
			false, -- bool bUseProjectile
			false, -- bool bFakeAttack
			false -- bool bNeverMiss
		)
    end)
	

end
 
function InitRangeAttack(kv)
	-- DebugPrint("[DOTARITE] Performing an attack")
	local attacker = kv.caster
	local ability = kv.ability

	local attacksPerSecond = attacker:GetAttacksPerSecond()
	local attackSpeed = ( 1 / attacksPerSecond )

	ability:StartCooldown(attackSpeed)
end 