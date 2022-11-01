hero_executioner_unimaginablestrength_modifier = class({})

function hero_executioner_unimaginablestrength_modifier:IsHidden()
	return true
end

function hero_executioner_unimaginablestrength_modifier:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE  
	}
end

function hero_executioner_unimaginablestrength_modifier:OnCreated()
	self.eCaster = self:GetCaster()
	self.hAbility = self:GetAbility()

	self:StartIntervalThink(0.03)
end

function hero_executioner_unimaginablestrength_modifier:OnIntervalThink()
	if not IsServer() then return end

	if self.hAbility:GetAutoCastState() and not self.hAbility:IsOwnersManaEnough() then
		self.hAbility:ToggleAutoCast()
	end
end

function hero_executioner_unimaginablestrength_modifier:OnOrder(eventInfo)
	local bFlags = {
		not IsServer(),
		eventInfo.unit ~= self.eCaster,
		eventInfo.unit:IsIllusion()
	}

	if bFlags[1] or bFlags[2] or bFlags[3] then
		return
	end

	if self.hAbility.bManualCast then
		self.hAbility.bManualCast = false
	end
end

function hero_executioner_unimaginablestrength_modifier:OnAttackLanded(eventInfo)
	local bFlags = {
		not IsServer(),
		eventInfo.attacker ~= self.eCaster,
		eventInfo.attacker:IsIllusion()
	}

	if bFlags[1] or bFlags[2] or bFlags[3] then
		return
	end

	local eTarget = eventInfo.target
	local bAutocast = self.hAbility:GetAutoCastState()

	if (self.hAbility.bManualCast or bAutocast) and self.hAbility:IsOwnersManaEnough() then
		EmitSoundOn("Hero_FacelessVoid.TimeLockImpact", eTarget)
		self.hAbility:PayManaCost()
		self.hAbility.bManualCast = false

		local fStrengthDamagePercent = self.hAbility:GetSpecialValueFor("strength_damage_pct")
		local fStrengthStunPercent = self.hAbility:GetSpecialValueFor("strength_stun_pct")

		local fStrength = self.eCaster:GetStrength()

		local fDamage = fStrength * (fStrengthDamagePercent / 100)
		local fStunDuration = fStrength * (fStrengthStunPercent / 100)

		eTarget:AddNewModifier(self.eCaster, self.hAbility, "modifier_stunned", {duration = fStunDuration})
	end
end

function hero_executioner_unimaginablestrength_modifier:GetModifierPreAttack_BonusDamage()
	if not IsServer() then return end

	local bAutocast = self.hAbility:GetAutoCastState()
	
	if (self.hAbility.bManualCast or bAutocast) and self.hAbility:IsOwnersManaEnough() then
		local fStrengthDamagePercent = self.hAbility:GetSpecialValueFor("strength_damage_pct")
		local fStrength = self.eCaster:GetStrength()
		local fDamage = fStrength * (fStrengthDamagePercent / 100)

		return fDamage
	end
end