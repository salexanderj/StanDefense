modifier_item_standef_inspiringheaddress_aura = class({})

function modifier_item_standef_inspiringheaddress_aura:IsHidden()
	return false
end

function modifier_item_standef_inspiringheaddress_aura:DeclareFunctions()
	
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
	}
end

function modifier_item_standef_inspiringheaddress_aura:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("aura_armor")
end

function modifier_item_standef_inspiringheaddress_aura:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("aura_health_regen")
end

function modifier_item_standef_inspiringheaddress_aura:GetModifierExtraHealthPercentage()
	return self:GetAbility():GetSpecialValueFor("aura_health_pct")
end

function modifier_item_standef_inspiringheaddress_aura:OnAttackLanded(eventInfo)

	if not IsServer() or
	 eventInfo.target:IsBuilding() or
	  eventInfo.attacker ~= self:GetParent() or
	   eventInfo.attacker:IsIllusion() or
	    self:GetParent():IsIllusion() then
		return
	end

	local fLifestealPercent = self:GetAbility():GetSpecialValueFor("aura_lifesteal")
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