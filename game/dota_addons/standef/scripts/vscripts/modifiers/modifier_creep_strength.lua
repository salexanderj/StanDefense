modifier_creep_strength = class({})

function modifier_creep_strength:IsHidden()
	return false
end

function modifier_creep_strength:GetTexture()
	return "creep_strength"
end

function modifier_creep_strength:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_creep_strength:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_SCALE
	}
end

function modifier_creep_strength:GetModifierModelScale()
	local iStacks = self:GetStackCount()

	return 1 + (iStacks * 0.9)
end