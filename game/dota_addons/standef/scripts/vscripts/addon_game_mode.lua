require("game_setup")
require("player_manager")
require("lane_creep_manager")
require("lane_boss_manager")
require("neutral_creep_manager")
require("constants")
require("libraries/CosmeticLib")

if CStanDefence == nil then
	CStanDefence = class({})
end

function Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sniper.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tiny.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_chaos_knight.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sven.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_dragon_knight.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_beastmaster.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_invoker.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_nightstalker.vsndevts", context)


	--CosmeticLib
	PrecacheResource("model", "models/development/invisiblebox.vmdl", context)
	PrecacheResource("model_folder", "models/heroes/antimage", context)
	PrecacheResource("model_folder", "models/items/antimage", context)
end

-- Create the game mode when we activate
function Activate()
	GameRules.GameMode = CStanDefence()
	GameRules.GameMode:init()

	CGameSetup:init()
	CPlayerManager:init()
	CLaneCreepManager:init()
	CLaneBossManager:init()
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