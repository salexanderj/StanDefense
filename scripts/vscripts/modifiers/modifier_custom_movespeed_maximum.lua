require("constants")

modifier_custom_movespeed_maximum = class({})

function modifier_custom_movespeed_maximum:IsHidden()
	return true
end

function modifier_custom_movespeed_maximum:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_custom_movespeed_maximum:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT
	}
end

function modifier_custom_movespeed_maximum:GetModifierIgnoreMovespeedLimit()
	return 1
end

function modifier_custom_movespeed_maximum:GetModifierMoveSpeed_Limit()
	return HERO_MOVESPEED_LIMIT
end