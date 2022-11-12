require("constants_tables")

if CGameSetup == nil then
  CGameSetup = class({})
end

function CGameSetup:init()
  if IsInToolsMode() then  --debug build
    --skip all the starting game mode stages e.g picking screen, showcase, etc
    GameRules:EnableCustomGameSetupAutoLaunch(true)
    GameRules:SetCustomGameSetupAutoLaunchDelay(0)
    GameRules:SetHeroSelectionTime(10)
    GameRules:SetStrategyTime(0)
    GameRules:SetPreGameTime(0)
    GameRules:SetShowcaseTime(0)
    GameRules:SetPostGameTime(5)
    GameRules:SetStartingGold(99999)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 0)
    --Remove this when more heroes are added
    GameRules:SetSameHeroSelectionEnabled(true)

    --disable some setting which are annoying then testing
    local GameMode = GameRules:GetGameModeEntity()
    GameMode:SetTopBarTeamValuesOverride(true)
    GameMode:SetTopBarTeamValuesVisible(false)
    GameMode:SetAnnouncerDisabled(true)
    GameMode:SetKillingSpreeAnnouncerDisabled(true)
    GameMode:SetDaynightCycleDisabled(true)
    GameMode:DisableHudFlip(true)
    GameMode:SetDeathOverlayDisabled(true)
    GameMode:SetWeatherEffectsDisabled(true)
    GameMode:SetFixedRespawnTime(30.0)
    GameMode:SetCustomHeroMaxLevel(100)
    GameMode:SetUseCustomHeroLevels(true)
    GameMode:SetCustomXPRequiredToReachNextLevel(HERO_LEVEL_XP_TABLE)
    GameMode:SetCustomBackpackSwapCooldown(0)

    --disable music events
    GameRules:SetCustomGameAllowHeroPickMusic(false)
    GameRules:SetCustomGameAllowMusicAtGameStart(false)
    GameRules:SetCustomGameAllowBattleMusic(false)

    --multiple players can pick the same hero
    GameRules:SetSameHeroSelectionEnabled(true)
    
    --listen to game state event
    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(self, "OnStateChange"), self)
    
  else --release build
    GameRules:EnableCustomGameSetupAutoLaunch(true)
    GameRules:SetCustomGameSetupAutoLaunchDelay(0)
    GameRules:SetPreGameTime(0)
    GameRules:SetShowcaseTime(0)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 0)
    --Remove this when more heroes are added
    GameRules:SetSameHeroSelectionEnabled(true)

    local GameMode = GameRules:GetGameModeEntity()
    GameMode:SetTopBarTeamValuesOverride(true)
    GameMode:SetTopBarTeamValuesVisible(false)
    GameMode:SetFixedRespawnTime(30.0)
    GameMode:SetCustomHeroMaxLevel(100)
    GameMode:SetUseCustomHeroLevels(true)
    GameMode:SetCustomXPRequiredToReachNextLevel(HERO_LEVEL_XP_TABLE)
    GameMode:SetCustomBackpackSwapCooldown(0)
  end
end

function CGameSetup:OnStateChange()
  --random hero once we reach strategy phase
  if GameRules:State_Get() == DOTA_GAMERULES_STATE_STRATEGY_TIME then
    CGameSetup:RandomForNoHeroSelected()
  end
end

function CGameSetup:RandomForNoHeroSelected()
    --NOTE: GameRules state must be in HERO_SELECTION or STRATEGY_TIME to pick heroes
    --loop through each player on every team and random a hero if they haven't picked
  local maxPlayers = 5
  for teamNum = DOTA_TEAM_GOODGUYS, DOTA_TEAM_BADGUYS do
    for i=1, maxPlayers do
      local playerID = PlayerResource:GetNthPlayerIDOnTeam(teamNum, i)
      if playerID ~= nil then
        if not PlayerResource:HasSelectedHero(playerID) then
          local hPlayer = PlayerResource:GetPlayer(playerID)
          if hPlayer ~= nil then
            hPlayer:MakeRandomHeroSelection()
          end
        end
      end
    end
  end
end