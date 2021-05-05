centaur_passive = class({})
LinkLuaModifier("modifier_centaur_passive", "pve/abilities/heroes/centaur/centaur_passive/modifier_centaur_passive", LUA_MODIFIER_MOTION_NONE)

function centaur_passive:GetIntrinsicModifierName()
    return "modifier_centaur_passive"
end