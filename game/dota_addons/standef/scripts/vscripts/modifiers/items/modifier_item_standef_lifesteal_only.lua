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

	if not IsServer() or
	 eventInfo.target:IsBuilding() or
	  eventInfo.attacker ~= self:GetParent() or
	   eventInfo.attacker:IsIllusion() or
	    self:GetParent():IsIllusion() then
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