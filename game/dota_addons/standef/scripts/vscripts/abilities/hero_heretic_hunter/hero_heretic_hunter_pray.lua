LinkLuaModifier("hero_heretic_hunter_pray_modifier", "modifiers/abilities/hero_heretic_hunter/hero_heretic_hunter_pray_modifier", LUA_MODIFIER_MOTION_NONE)

hero_heretic_hunter_pray = class({})

function hero_heretic_hunter_pray:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_dawnbreaker.vsndevts", context)
end

function hero_heretic_hunter_pray:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local fMaxDuration = self:GetChannelTime()

	eCaster:AddNewModifier(eCaster, self, "hero_heretic_hunter_pray_modifier", {duration = fMaxDuration})

	self.iParticleIDs = self.iParticleIDs or {}

	local sParticleName = "particles/items_fx/aura_vlads.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN_FOLLOW, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
	table.insert(self.iParticleIDs, iParticleID)

	local sParticleName = "particles/units/heroes/hero_grimstroke/grimstroke_phantom_marker_arc_glow.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN_FOLLOW, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 3, eCaster:GetAbsOrigin())
	table.insert(self.iParticleIDs, iParticleID)

	EmitSoundOn("Hero_Dawnbreaker.Luminosity.Heal", eCaster)
end

function hero_heretic_hunter_pray:OnChannelFinish(bInterrupted)
	if not IsServer() then return end

	local eCaster = self:GetCaster()

	eCaster:RemoveModifierByName("hero_heretic_hunter_pray_modifier")

	for i, v in ipairs(self.iParticleIDs) do
		if v ~= nil then
			ParticleManager:DestroyParticle(v, true)
			ParticleManager:ReleaseParticleIndex(v)
		end
	end

	for i, v in ipairs(self.iParticleIDs) do
		table.remove(self.iParticleIDs, i)
	end
end