modifier_item_standef_enchantedtalisman = class({})

function modifier_item_standef_enchantedtalisman:IsHidden()
	return true
end

function modifier_item_standef_enchantedtalisman:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE  
end

function modifier_item_standef_enchantedtalisman:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_EVENT_ON_DEATH
	}
end

function modifier_item_standef_enchantedtalisman:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intelligence")
end

function modifier_item_standef_enchantedtalisman:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_standef_enchantedtalisman:GetModifierSpellAmplify_Percentage()
	return self:GetAbility():GetSpecialValueFor("spell_amp_pct")
end

function modifier_item_standef_enchantedtalisman:OnAbilityExecuted(eventInfo)
	if not IsServer() then return end

	local eParent = self:GetParent()

	if eventInfo.unit == eParent and not eventInfo.ability:IsItem() then

		local fRadius = self:GetAbility():GetSpecialValueFor("pulse_range")

		local tEnemyUnits = FindUnitsInRadius(
			eParent:GetTeam(), 
			eParent:GetAbsOrigin(), 
			nil, 
			fRadius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false)

		local fDamage = self:GetAbility():GetSpecialValueFor("pulse_damage")

		if(#tEnemyUnits > 0) then
			EmitSoundOn("Item.WraithTotem.Pulse", eParent)
		end

		for i, v in ipairs(tEnemyUnits) do
			local hOptions = {
				victim = v,
				attacker = eParent,
				damage = fDamage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				ability = self:GetAbility()
			}
			ApplyDamage(hOptions)

			local sParticleName = "particles/units/heroes/hero_slark/slark_dark_pact_pulses_flash_body.vpcf"
			local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN_FOLLOW, v)
			ParticleManager:ReleaseParticleIndex(iParticleID)
		end
	end
end

function modifier_item_standef_enchantedtalisman:OnDeath(eventInfo)
	local eKilledUnit = eventInfo.unit

	local eParent = self:GetParent()
	if not IsServer() or
	 not eKilledUnit or
	 eKilledUnit:GetTeam() == DOTA_TEAM_GOODGUYS or
	 eventInfo.attacker ~= eParent or
	 not eParent:IsHero() then 
	 	return
	end

	local ePlayer = eParent:GetPlayerOwner()

	local fGoldAmount = self:GetAbility():GetSpecialValueFor("bonus_gold_per_kill")

	eParent:ModifyGold(fGoldAmount, true, DOTA_ModifyGold_CreepKill)
	SendOverheadEventMessage(ePlayer, OVERHEAD_ALERT_GOLD, self:GetParent(), fGoldAmount, ePlayer)
end