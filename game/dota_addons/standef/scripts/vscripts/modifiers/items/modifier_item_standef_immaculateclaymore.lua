modifier_item_standef_immaculateclaymore = class({})

function modifier_item_standef_immaculateclaymore:IsHidden()
	return true
end

function modifier_item_standef_immaculateclaymore:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_immaculateclaymore:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end

function modifier_item_standef_immaculateclaymore:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_immaculateclaymore:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end

function modifier_item_standef_immaculateclaymore:OnAttackLanded(eventInfo)

	local eParent = self:GetParent()
	local fChance = self:GetAbility():GetSpecialValueFor("proc_chance_pct")

	if not IsServer() or
	 eventInfo.attacker ~= eParent or
	  eventInfo.attacker:IsIllusion() or 
	  not RollPercentage(fChance) then
		return
	end

	EmitSoundOn("DOTA_Item.MKB.melee", eParent)

	local eTarget = eventInfo.target

	local fLifestealPercentage = self:GetAbility():GetSpecialValueFor("proc_lifesteal_pct")
	local fDamagePercentage = self:GetAbility():GetSpecialValueFor("proc_mult_pct")
	local fFullDamage = eventInfo.damage * (fDamagePercentage / 100)
	local fTotalHeal = fFullDamage * (fLifestealPercentage / 100)

	local hOptions = {
		victim = eTarget,
		attacker = eParent,
		damage = fFullDamage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self:GetAbility()
	}
	ApplyDamage(hOptions)

	local fCleavePercentage = self:GetAbility():GetSpecialValueFor("proc_cleave_pct")
	local fCleaveDamage = fFullDamage * (fCleavePercentage / 100)
	DoCleaveAttack(eParent, eTarget, self:GetAbility(), fCleaveDamage, 200, 350, 600, "particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave_gods_strength.vpcf")


	local sParticleName = "particles/generic_gameplay/generic_lifesteal.vpcf"
	if fTotalHeal > 0 then
		eParent:Heal(fTotalHeal, nil)
		local iParticleID =  ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, eParent)
		ParticleManager:SetParticleControl(iParticleID, 0, eParent:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
end