modifier_item_standef_novablade_armor_reduction = class({})

function modifier_item_standef_novablade_armor_reduction:IsHidden()
	return false
end

function modifier_item_standef_novablade_armor_reduction:IsDebuff()
	return true
end

function modifier_item_standef_novablade_armor_reduction:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_item_standef_novablade_armor_reduction:OnCreated(eventInfo)

	local eCaster = self:GetAbility():GetCaster()
		
	local fAgility = eCaster:GetAgility()
	local fMultiplier = self:GetAbility():GetSpecialValueFor("agility_armor_reduction_pct") / 100
	self.fReduction = fAgility * fMultiplier	 
end

function modifier_item_standef_novablade_armor_reduction:GetModifierPhysicalArmorBonus()
	return -self.fReduction
end