LinkLuaModifier("modifier_item_standef_charmedjavelin", "modifiers/items/modifier_item_standef_charmedjavelin", LUA_MODIFIER_MOTION_NONE)

item_standef_spiritjavelin = class({})

function item_standef_spiritjavelin:GetIntrinsicModifierName()
	return "modifier_item_standef_charmedjavelin"
end

function item_standef_spiritjavelin:OnSpellStart()
	
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local eTarget = self:GetCursorTarget()
	local fDamage = self:GetSpecialValueFor("active_damage")

	local hOptions = {
		victim = eTarget,
		attacker = eCaster,
		damage = fDamage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self
	}
	ApplyDamage(hOptions)

	EmitSoundOn("DOTA_Item.Nullifier.Slow", eCaster)
	EmitSoundOn("DOTA_Item.Maim", eTarget)

	local sParticleName = "particles/econ/events/ti5/dagon_ti5.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
	ParticleManager:SetParticleControl(iParticleID, 1, eTarget:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(iParticleID)

	local sParticleName = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace_hit_blood.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eTarget)
	ParticleManager:ReleaseParticleIndex(iParticleID)
end
