modifier_item_standef_lifesteal_only = class({})

function modifier_item_standef_lifesteal_only:IsHidden()
	return true
end

function modifier_item_standef_lifesteal_only:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_lifesteal_only:DeclareFunctions()

	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
	}
end

function modifier_item_standef_lifesteal_only:OnAttackLanded(eventInfo)

	local bFlags = {
		not IsServer(),
		eventInfo.target:IsBuilding(),
		eventInfo.attacker ~= self:GetParent(),
		eventInfo.attacker:IsIllusion(),
		self:GetParent():IsIllusion()
	}

	if bFlags[1] or bFlags[2] or bFlags[3] or bFlags[4] or bFlags[5] then
		return
	end

	local fLifestealPercent = self:GetAbility():GetSpecialValueFor("lifesteal_pct")
	local fLifestealMultiplierPercent = 100
	if self.GetModifierLifestealRegenAmplify_Percentage then
		fLifestealMultiplierPercent = self:GetModifierLifestealRegenAmplify_Percentage()
	end
	local sParticlePath = "particles/generic_gameplay/generic_lifesteal.vpcf"
	local fDamage = eventInfo.damage

	local fLifestealHeal = fDamage * (fLifestealPercent * (1 + fLifestealMultiplierPercent/100))/100

	if fLifestealHeal > 0 then
		eventInfo.attacker:Heal(fLifestealHeal, nil)
		local hParticle =  ParticleManager:CreateParticle(sParticlePath, PATTACH_ABSORIGIN, eventInfo.attacker)
		ParticleManager:SetParticleControl(hParticle, 0, eventInfo.attacker:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(hParticle)
	end
end