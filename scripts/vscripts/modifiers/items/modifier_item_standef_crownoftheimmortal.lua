modifier_item_standef_crownoftheimmortal = class({})

function modifier_item_standef_crownoftheimmortal:IsHidden()
	return true
end

function modifier_item_standef_crownoftheimmortal:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_crownoftheimmortal:DeclareFunctions()

	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE
	}
end

function modifier_item_standef_crownoftheimmortal:OnAttackLanded(eventInfo)

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

function modifier_item_standef_crownoftheimmortal:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_standef_crownoftheimmortal:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_item_standef_crownoftheimmortal:OnTakeDamage(eventInfo)

	local bFlags = {
		eventInfo.unit ~= self:GetParent(),
		self:GetParent():IsIllusion()
	}

	if bFlags[1] or bFlags[2] then 
		return
	end

	local fChance = self:GetAbility():GetSpecialValueFor("resurrection_chance_pct")

	if eventInfo.unit:GetHealth() <= 1 and RollPercentage(fChance) then
		local iMaxHealth = eventInfo.unit:GetMaxHealth()
		eventInfo.unit:Heal(iMaxHealth / 2, self:GetAbility())
		eventInfo.unit:EmitSound("Item.MinotaurHorn.Cast")
		local hParticle = ParticleManager:CreateParticle("particles/econ/events/ti10/portal/portal_revealed_nothing_good_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, eventInfo.unit)
		ParticleManager:SetParticleControlEnt(hParticle, 0, eventInfo.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", eventInfo.unit:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(hParticle)
	end
end