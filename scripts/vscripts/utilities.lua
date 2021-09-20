function Split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

function GetNextWaypointName(sCurrentWaypointName)
        local sSplitStrings = Split(sCurrentWaypointName, "_")
        local iCurrentNumber = tonumber(sSplitStrings[#sSplitStrings])

        if type(iCurrentNumber) ~= "number" or #sSplitStrings < 2 then
                return nil
        end

        local sNextWaypointName = ""
        for i = 1, (#sSplitStrings - 1) do
                sNextWaypointName = sNextWaypointName .. sSplitStrings[i] .. "_"
        end

        sNextWaypointName = sNextWaypointName .. tostring(iCurrentNumber + 1)

        return sNextWaypointName
end

-- Initial launch + main loop
function LaunchLightning(caster, target, ability, damage, bounce_radius)
        if target:IsMagicImmune() then
                return
        end

        -- Parameters
        local targets_hit = { target }
        local search_sources = { target }

        -- Play initial sound
        caster:EmitSound("Item.Maelstrom.Chain_Lightning")

        -- Play first bounce sound
        target:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")
        ZapThem(caster, ability, caster, target, damage)

        -- While there are potential sources, keep looping
        while #search_sources > 0 do

                -- Loop through every potential source this iteration
                for potential_source_index, potential_source in pairs(search_sources) do

                        local nearby_enemies = FindUnitsInRadius(caster:GetTeamNumber(), potential_source:GetAbsOrigin(), nil, bounce_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)

                        for _, potential_target in pairs(nearby_enemies) do

                                -- Check if this target was already hit
                                local already_hit = false
                                for _, hit_target in pairs(targets_hit) do
                                        if potential_target == hit_target then
                                                already_hit = true
                                                break
                                        end
                                end

                                -- If not, zap it from this source, and mark it as a hit target and potential future source
                                if not already_hit then
                                        ZapThem(caster, ability, potential_source, potential_target, damage)
                                        targets_hit[#targets_hit+1] = potential_target
                                        search_sources[#search_sources+1] = potential_target
                                end
                        end

                        -- Remove this potential source
                        table.remove(search_sources, potential_source_index)
                end
        end
end

-- One bounce. Particle + damage
function ZapThem(caster, ability, source, target, damage)
        -- Draw particle
        local particle = "particles/items_fx/chain_lightning.vpcf"
        if ability:GetAbilityName() == "item_imba_jarnbjorn" then
                particle = "particles/items_fx/chain_lightning_jarnbjorn.vpcf"
        end

        local bounce_pfx = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, source)
        ParticleManager:SetParticleControlEnt(bounce_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(bounce_pfx, 1, source, PATTACH_POINT_FOLLOW, "attach_hitloc", source:GetAbsOrigin(), true)
        ParticleManager:SetParticleControl(bounce_pfx, 2, Vector(1, 1, 1))
        ParticleManager:ReleaseParticleIndex(bounce_pfx)

        ApplyDamage({attacker = caster, victim = target, ability = ability, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
end