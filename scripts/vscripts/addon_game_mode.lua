require("game_setup")
require("player_manager")
require("lane_creep_manager")
require("neutral_creep_manager")
require("constants")

if CStanDefence == nil then
	CStanDefence = class({})
end

function Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context )
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sniper.vsndevts", context )
end

-- Create the game mode when we activate
function Activate()
	GameRules.GameMode = CStanDefence()
	GameRules.GameMode:init()

	CGameSetup:init()
	CPlayerManager:init()
	CLaneCreepManager:init()
	CNeutralCreepManager:init()
end

function CStanDefence:init()
	print( "Stan Defence is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
end

-- Evaluate the state of the game
function CStanDefence:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end