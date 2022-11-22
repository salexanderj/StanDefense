LinkLuaModifier("modifier_item_standef_opulentboots", "modifiers/items/modifier_item_standef_opulentboots", LUA_MODIFIER_MOTION_NONE)

item_standef_opulentboots = class({})

function item_standef_opulentboots:GetIntrinsicModifierName()
	return "modifier_item_standef_opulentboots"
end

function item_standef_opulentboots:OnSpellStart()

	local sTeleportStartParticle = "particles/items2_fx/teleport_start.vpcf"
	local sTeleportEndParticle = "particles/items2_fx/teleport_end.vpcf"
	local eCaster = self:GetCaster()
	local vTargetPosition = self:GetCursorPosition()
	self.vArrivePosition = vTargetPosition
	EmitSoundOn("Portal.Loop_Disappear", eCaster)

	self.eEmitter = CreateUnitByName("npc_dummy_unit", vTargetPosition, false, eCaster, eCaster, eCaster:GetTeamNumber())
	EmitSoundOn("Portal.Loop_Appear", self.eEmitter)

	self.iStartParticleID = ParticleManager:CreateParticle(sTeleportStartParticle, PATTACH_WORLDORIGIN, eCaster)
	ParticleManager:SetParticleControl(self.iStartParticleID, 0, eCaster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.iStartParticleID, 2, Vector(255,255,0))
	ParticleManager:SetParticleControl(self.iStartParticleID, 3, eCaster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.iStartParticleID, 4, eCaster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.iStartParticleID, 5, Vector(3,0,0))
	ParticleManager:SetParticleControl(self.iStartParticleID, 6, eCaster:GetAbsOrigin())

	self.iEndParticleID = ParticleManager:CreateParticle(sTeleportEndParticle, PATTACH_CUSTOMORIGIN, eCaster)
	ParticleManager:SetParticleControl(self.iEndParticleID, 0, vTargetPosition)
	ParticleManager:SetParticleControl(self.iEndParticleID, 1, vTargetPosition)
	ParticleManager:SetParticleControl(self.iEndParticleID, 5, vTargetPosition)
	ParticleManager:SetParticleControl(self.iEndParticleID, 4, Vector(1,0,0))
	ParticleManager:SetParticleControlEnt(self.iEndParticleID, 3, eCaster, PATTACH_CUSTOMORIGIN, "attach_hitloc", vTargetPosition, true)
end

function item_standef_opulentboots:OnChannelFinish(bInterrupted)
	local eCaster = self:GetCaster()

	if bInterrupted then
		ParticleManager:DestroyParticle(self.iStartParticleID, true)
		ParticleManager:DestroyParticle(self.iEndParticleID, true)
	else
		ParticleManager:DestroyParticle(self.iStartParticleID, false)
		ParticleManager:DestroyParticle(self.iEndParticleID, false)
		EmitSoundOnLocationWithCaster(eCaster:GetAbsOrigin(), "Portal.Hero_Disappear", eCaster)
		FindClearSpaceForUnit(eCaster, self.vArrivePosition, true)
		EmitSoundOnLocationWithCaster(eCaster:GetAbsOrigin(), "Portal.Hero_Appear", eCaster)
	end

	StopSoundOn("Portal.Loop_Disappear", eCaster)
	StopSoundOn("Portal.Loop_Appear", self.eEmitter)
	UTIL_Remove(self.eEmitter)
	ParticleManager:ReleaseParticleIndex(self.iStartParticleID)
	ParticleManager:ReleaseParticleIndex(self.iEndParticleID)
end