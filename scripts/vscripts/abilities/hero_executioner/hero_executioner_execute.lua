require("libraries/timers")

hero_executioner_execute = class({})

function hero_executioner_execute:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)				
end

function hero_executioner_execute:GetManaCost(iLevel)
	return self:GetCaster():GetMana()
end

function hero_executioner_execute:GetChannelTime()
	return self:GetSpecialValueFor("channel_time")
end

function hero_executioner_execute:OnSpellStart()

	local eCaster = self:GetCaster()
	local eTarget = self:GetCursorTarget()

	self.eTarget = eTarget

	self:RefundManaCost()

	eTarget:AddNewModifier(eCaster, self, "modifier_rooted", {duration = self:GetChannelTime()})
	eCaster:AddNewModifier(eCaster, self, "modifier_magic_immune", {duration = self:GetChannelTime()})

	if not IsServer() then return end

	EmitSoundOn("Hero_Oracle.PurifyingFlames", eCaster)
	EmitSoundOn("Hero_FacelessVoid.Chronosphere.MaceOfAeons", eCaster)

	local sParticleName = "particles/econ/taunts/void_spirit/void_spirit_taunt_impact_shockwave.vpcf"

	Timers:CreateTimer(function()
			local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN_FOLLOW, eCaster)
			ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(iParticleID)

			if self:IsChanneling() then 
				return 0.5
			else 
				return nil
			end
		end
	)
end

function hero_executioner_execute:OnChannelFinish(bInterrupted)
	if not IsServer() or not self.eTarget then return end

	local eCaster = self:GetCaster()
	local eTarget = self.eTarget

	if bInterrupted then
		eTarget:RemoveModifierByNameAndCaster("modifier_rooted", eCaster)
		eCaster:RemoveModifierByNameAndCaster("modifier_magic_immune", eCaster)
	else
		local fStatMultiplier = self:GetSpecialValueFor("all_stat_damage_pct") / 100
		local fAgility = eCaster:GetAgility()
		local fStrength = eCaster:GetStrength()
		local fIntelligence = eCaster:GetIntellect()
		local fSpellAmp = eCaster:GetSpellAmplification(false)

		local fDamage = ((fAgility + fStrength + fIntelligence) * fStatMultiplier) * (1 + fSpellAmp)

		eCaster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 2)

		EmitSoundOn("DOTA_Item.Force_Boots.Cast", eCaster)
		EmitSoundOn("Hero_FacelessVoid.PreAttack", eCaster)
		EmitSoundOn("Hero_FacelessVoid.PreAttack", eCaster)

		self:PayManaCost()

		local fAttackPoint = eCaster:GetAttackAnimationPoint() / 2
		Timers:CreateTimer({
			endTime = fAttackPoint,
			callback = function()
			local hOptions = {
				victim = eTarget,
				attacker = eCaster,
				damage = fDamage,
				damage_type = self:GetAbilityDamageType(),
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				ability = self
			}
			ApplyDamage(hOptions)

			EmitSoundOn("Hero_FacelessVoid.TimeLockImpact", eTarget)
			EmitSoundOn("Item.BlackPowder", eTarget)
			EmitSoundOn("Item.BlackPowder", eTarget)

			local sParticleName = "particles/econ/items/slardar/slardar_takoyaki_gold/slardar_crush_tako_shockwave_ring_gold.vpcf"
			local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN_FOLLOW, eTarget)
			ParticleManager:SetParticleControl(iParticleID, 0, eTarget:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(iParticleID)

			local sParticleName = "particles/econ/items/earthshaker/earthshaker_ti9/earthshaker_fissure_ti9_lvl2_start_rocks.vpcf"
			local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN_FOLLOW, eTarget)
			ParticleManager:SetParticleControl(iParticleID, 0, eTarget:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(iParticleID)

			eCaster:RemoveModifierByNameAndCaster("modifier_magic_immune", eCaster)
			eTarget:RemoveModifierByNameAndCaster("modifier_rooted", eCaster)
			end
		})
	end
end