modifier_item_standef_vampiricdraught = class({})

function modifier_item_standef_vampiricdraught:GetEffectName()
	return "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf"
end

function modifier_item_standef_vampiricdraught:GetEffectAttachType()
	return PATTACH_ROOTBONE_FOLLOW
end

function modifier_item_standef_vampiricdraught:IsHidden()
	return false
end

function modifier_item_standef_vampiricdraught:OnCreated()
	self.iBonusAttackSpeed = self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
	self.iPercentLifesteal = self:GetAbility():GetSpecialValueFor("lifesteal_pct")
end

function modifier_item_standef_vampiricdraught:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
	}
end

function modifier_item_standef_vampiricdraught:GetModifierAttackSpeedBonus_Constant()
	return self.iBonusAttackSpeed
end

function modifier_item_standef_vampiricdraught:OnAttackLanded(eventInfo)

	if not IsServer() or
	 eventInfo.target:IsBuilding() or
	  eventInfo.attacker ~= self:GetParent() or
	   eventInfo.attacker:IsIllusion() or
	    self:GetParent():IsIllusion() then
		return
	end

	local fLifestealMultiplierPercent = 100
	if self.GetModifierLifestealRegenAmplify_Percentage then
		fLifestealMultiplierPercent = self:GetModifierLifestealRegenAmplify_Percentage()
	end
	local sParticlePath = "particles/generic_gameplay/generic_lifesteal.vpcf"
	local fDamage = eventInfo.damage

	local fLifestealHeal = fDamage * (self.iPercentLifesteal * (1 + fLifestealMultiplierPercent/100))/100

	if fLifestealHeal > 0 then
		eventInfo.attacker:Heal(fLifestealHeal, nil)
		local hParticle =  ParticleManager:CreateParticle(sParticlePath, PATTACH_ABSORIGIN, eventInfo.attacker)
		ParticleManager:SetParticleControl(hParticle, 0, eventInfo.attacker:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(hParticle)
	end
end