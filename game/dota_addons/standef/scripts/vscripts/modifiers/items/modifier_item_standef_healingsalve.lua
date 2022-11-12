modifier_item_standef_healingsalve = class({})

function modifier_item_standef_healingsalve:GetEffectName()
	return "particles/items_fx/healing_flask.vpcf"
end

function modifier_item_standef_healingsalve:GetTexture()
	return "item_standef_healingsalve"
end

function modifier_item_standef_healingsalve:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_standef_healingsalve:IsHidden()
	return false
end

function modifier_item_standef_healingsalve:OnCreated()
	self.iBonusHealthRegen = self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_item_standef_healingsalve:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end

function modifier_item_standef_healingsalve:GetModifierConstantHealthRegen()
	return self.iBonusHealthRegen
end