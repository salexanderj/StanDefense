boss_lane_guard_passive_modifier = class({})

function boss_lane_guard_passive_modifier:IsHidden()
	return false
end

function boss_lane_guard_passive_modifier:DeclareFunctions()

	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function boss_lane_guard_passive_modifier:OnTakeDamage(eventInfo)
	if not IsServer() or
		eventInfo.attacker:IsBuilding() or
		eventInfo.unit ~= self:GetParent() then
			return
	 end

	 		local fDamage = eventInfo.damage
			local fReturnPercentage = self:GetAbility():GetSpecialValueFor("return_damage_pct")
			local fReturnDamage = fDamage * (fReturnPercentage / 100)

			if fReturnDamage > 0 then
				local hOptions = {
					victim = eventInfo.attacker,
					attacker = self:GetParent(),
					damage = fReturnDamage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
					damage_flags = DOTA_DAMAGE_FLAG_NONE,
					ability = self:GetAbility()
				}
				ApplyDamage(hOptions)

				local sParticleName = "particles/units/heroes/hero_warlock/warlock_fatal_bonds_pulse.vpcf"
				local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ROOTBONE_FOLLOW, self:GetParent())
				ParticleManager:SetParticleControl(iParticleID, 1, eventInfo.attacker:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(iParticleID)
			end
end

function boss_lane_guard_passive_modifier:GetModifierStatusResistance()
	return self:GetAbility():GetSpecialValueFor("status_resist_pct")
end

function boss_lane_guard_passive_modifier:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("magic_resist_pct")
end
