modifier_item_standef_axe = class({})

function modifier_item_standef_axe:IsHidden()
	return true
end

function modifier_item_standef_axe:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_axe:DeclareFunctions()

	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end

function modifier_item_standef_axe:OnAttackLanded(eventInfo)
	
	if not IsServer() or
		eventInfo.target == nil or
		eventInfo.target:IsBuilding() or
		eventInfo.attacker ~= self:GetParent() or
		self:GetParent():IsRangedAttacker() then
		return
	end

	local fPercentCleave = self:GetAbility():GetSpecialValueFor("cleave_pct")
	local fCleaveDamage = eventInfo.damage * (fPercentCleave / 100)
	local iStartRadius = self:GetAbility():GetSpecialValueFor("cleave_start_radius")
	local iEndRadius = self:GetAbility():GetSpecialValueFor("cleave_end_radius")
	local iCleaveDistance = self:GetAbility():GetSpecialValueFor("cleave_distance")

	DoCleaveAttack(eventInfo.attacker, eventInfo.target, self:GetAbility(), fCleaveDamage, iStartRadius, iEndRadius, iCleaveDistance, "particles/items_fx/battlefury_cleave.vpcf")
end