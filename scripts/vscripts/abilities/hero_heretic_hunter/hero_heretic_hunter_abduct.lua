LinkLuaModifier("hero_heretic_hunter_abduct_modifier", "modifiers/abilities/hero_heretic_hunter/hero_heretic_hunter_abduct_modifier", LUA_MODIFIER_MOTION_HORIZONTAL)

hero_heretic_hunter_abduct = class({})

function hero_heretic_hunter_abduct:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_shredder.vsndevts", context)
end

function hero_heretic_hunter_abduct:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function hero_heretic_hunter_abduct:CastFilterResultLocation(vLocation)
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local iTargetFlags = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iRadius = self:GetAOERadius()
	local iTeam = self:GetTeamNumber()

	local eTargets = FindUnitsInRadius(iTeam, vLocation, nil, self:GetAOERadius(), DOTA_UNIT_TARGET_TEAM_ENEMY, iTargetFlags, 0, FIND_ANY_ORDER, false)

	if #eTargets < 1 then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function hero_heretic_hunter_abduct:GetCustomCastErrorLocation(vLocation)
	return "No targets"
end

function hero_heretic_hunter_abduct:OnSpellStart()
	if not IsServer() then return end

	self.hHooks = self.hHooks or {}
	self.fHookSpeed = 2500.0

	local eCaster = self:GetCaster()
	local vCasterPositon = eCaster:GetAbsOrigin()
	local vCursor = eCaster:GetCursorPosition()

	local iTargetFlags = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC

	local iRadius = self:GetAOERadius()
	local iTeam = self:GetTeamNumber()
	local eTargets = FindUnitsInRadius(iTeam, vCursor, nil, self:GetAOERadius(), DOTA_UNIT_TARGET_TEAM_ENEMY, iTargetFlags, 0, FIND_ANY_ORDER, false)

	EmitSoundOn("Hero_Shredder.TimberChain.Cast", eCaster)

	for i, v in ipairs(eTargets) do

		hProjectileOptions = 
		{	
			EffectName = "",
			Ability = self,
			Source = eCaster,
			bProvidesVision = false,
			iVisionRadius = 0,
			iVisionTeamNumber = iTeam,
			ExtraData = nil,
			vSourceLoc = vCasterPositon,
			Target = v,
			iMoveSpeed = self.fHookSpeed,
			flExpireTime = 30,
			bDodgeable = false,
			bIsAttack = false,
			bReplaceExisting = false,
			bIgnoreObstructions = true,
			bSuppressTargetCheck = false,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
			bDrawsOnMinimap = false,
			bVisibleToEnemies = true
		}

		local iProjectileID = ProjectileManager:CreateTrackingProjectile(hProjectileOptions)

		local hHookParticle = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_meathook.vpcf", PATTACH_CUSTOMORIGIN, eCaster)
		ParticleManager:SetParticleAlwaysSimulate(hHookParticle)
		ParticleManager:SetParticleControlEnt(hHookParticle, 0, eCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", vCasterPositon, true)
		ParticleManager:SetParticleControlEnt(hHookParticle, 1, v, PATTACH_POINT_FOLLOW, "attach_hitloc", v:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(hHookParticle, 2, Vector(self.fHookSpeed, (v:GetAbsOrigin() - vCasterPositon):Length(), 50))
		ParticleManager:SetParticleControl(hHookParticle, 3, Vector(60, 0, 0))
		ParticleManager:SetParticleControl(hHookParticle, 6, vCasterPositon)
		ParticleManager:SetParticleControlEnt(hHookParticle, 7, vCasterPosition, PATTACH_CUSTOMORIGIN, nil, vCasterPositon, true)

		self.hHooks[iProjectileID] = {}
		self.hHooks[iProjectileID].eTarget = v
		self.hHooks[iProjectileID].hHookParticle = hHookParticle
		self.hHooks[iProjectileID].bReturning = false
	end
end

function hero_heretic_hunter_abduct:OnProjectileHitHandle(eTarget, vPosition, iProjectileID)
	if not IsServer() then return end

	if not self.hHooks[iProjectileID] then
		if eTarget and eTarget.RemoveModifierByName then
			eTarget:RemoveModifierByName("hero_heretic_hunter_abduct_modifier")
		end
		ProjectileManager:DestroyTrackingProjectile(iProjectileID)
		return
	end

	if not self.hHooks[iProjectileID].bReturning and self.hHooks[iProjectileID].eTarget:IsAlive() then

		local eCaster = self:GetCaster()
		local eOriginalTarget = self.hHooks[iProjectileID].eTarget
		local hHookParticle = self.hHooks[iProjectileID].hHookParticle

		EmitSoundOn("Hero_Shredder.TimberChain.Impact", eOriginalTarget)

		local hOptions = {
			victim = eOriginalTarget,
			attacker = eCaster,
			damage = self:GetDamage(),
			damage_type = self:GetAbilityDamageType(),
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			ability = self
		}
		ApplyDamage(hOptions)

		eOriginalTarget:AddNewModifier(eCaster, self, "hero_heretic_hunter_abduct_modifier", {})

		hProjectileOptions = 
		{	
			EffectName = "",
			Ability = self,
			Source = eOriginalTarget,
			bProvidesVision = false,
			iVisionRadius = 0,
			iVisionTeamNumber = nil,
			ExtraData = nil,
			vSourceLoc = eOriginalTarget:GetAbsOrigin(),
			Target = eCaster,
			iMoveSpeed = self.fHookSpeed,
			flExpireTime = 30,
			bDodgeable = false,
			bIsAttack = false,
			bReplaceExisting = false,
			bIgnoreObstructions = true,
			bSuppressTargetCheck = false,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
			bDrawsOnMinimap = false,
			bVisibleToEnemies = true
		}
			
		self.hHooks[iProjectileID] = nil

		local iNewProjectileID = ProjectileManager:CreateTrackingProjectile(hProjectileOptions)

		self.hHooks[iNewProjectileID] = {}
		self.hHooks[iNewProjectileID].eTarget = eOriginalTarget
		self.hHooks[iNewProjectileID].hHookParticle = hHookParticle
		self.hHooks[iNewProjectileID].bReturning = true

	else

		local eCaster = self:GetCaster()
		local eOriginalTarget = self.hHooks[iProjectileID].eTarget
		local hHookParticle = self.hHooks[iProjectileID].hHookParticle

		FindClearSpaceForUnit(eOriginalTarget, eCaster:GetAbsOrigin(), false)

		ParticleManager:DestroyParticle(hHookParticle, true)
		ParticleManager:ReleaseParticleIndex(hHookParticle)

		eOriginalTarget:RemoveModifierByName("hero_heretic_hunter_abduct_modifier")

		self.hHooks[iProjectileID] = nil
	end

	return false
end

function hero_heretic_hunter_abduct:OnProjectileThinkHandle(iProjectileID)
	if not IsServer() then return end

	local eOriginalTarget = self.hHooks[iProjectileID].eTarget
	local hHookParticle = self.hHooks[iProjectileID].hHookParticle

	if not eOriginalTarget:IsAlive() then
		ParticleManager:DestroyParticle(hHookParticle, true)
		ParticleManager:ReleaseParticleIndex(hHookParticle)

		eOriginalTarget:RemoveModifierByName("hero_heretic_hunter_abduct_modifier")

		ProjectileManager:DestroyTrackingProjectile(iProjectileID)

	end

	if self.hHooks[iProjectileID] and self.hHooks[iProjectileID].bReturning then
		local vProjectileLocation = ProjectileManager:GetTrackingProjectileLocation(iProjectileID)

		eOriginalTarget:SetAbsOrigin(vProjectileLocation)
	end
end

function hero_heretic_hunter_abduct:GetDamage()

	local fDamagePerAgiPercent = self:GetSpecialValueFor("damage_per_agi_pct")
	local fCurrentAgility = self:GetCaster():GetAgility()
	local fSpellAmp = self:GetCaster():GetSpellAmplification(false)

	local fDamage = (fCurrentAgility * (fDamagePerAgiPercent / 100)) * (1 + fSpellAmp)

	return fDamage
end