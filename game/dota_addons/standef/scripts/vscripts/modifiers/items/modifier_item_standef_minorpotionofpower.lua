modifier_item_standef_minorpotionofpower = class({})

function modifier_item_standef_minorpotionofpower:GetEffectName()
	return "particles/items_fx/healing_clarity.vpcf"
end

function modifier_item_standef_minorpotionofpower:GetTexture()
	return "item_standef_minorpotionofpower"
end

function modifier_item_standef_minorpotionofpower:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_standef_minorpotionofpower:IsHidden()
	return false
end

function modifier_item_standef_minorpotionofpower:OnCreated()
	self.fBonusManaRegen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
	self.fPercentBonusSpellAmp = self:GetAbility():GetSpecialValueFor("bonus_spell_amp_pct")
end

function modifier_item_standef_minorpotionofpower:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_item_standef_minorpotionofpower:GetModifierConstantManaRegen()
	return self.fBonusManaRegen
end

function modifier_item_standef_minorpotionofpower:GetModifierSpellAmplify_Percentage()
	return self.fPercentBonusSpellAmp
end