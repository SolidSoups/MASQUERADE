extends Node

var playerNode: CharacterBody3D = null
var eyes = false
var nose = false
var mouth = false
var ears = false
var dialogue = false
var game_over = false
var dialogue_cooldown = 0.0
var dialogue_cooldown_max = 5.0
enum dialogue_presets{jimobob,guy,lady}
var dialogue_preset = dialogue_presets.guy
var mask_up = true
var debug_mask_disabled = false
var seen = false

enum sus_levels{none, low, medium, high, exposed}
var suspicion = 0.0
var suspicion_max = 5.0
var suspicion_level = sus_levels.none
var has_won: bool = false

func _process(delta: float) -> void:
	clampf(suspicion,0.0,suspicion_max)
	suspicion_level = int(suspicion)
	clampf(suspicion,0.0,suspicion_max)

func reset():
	playerNode = null
	eyes = false
	nose = false
	mouth = false
	ears = false
	dialogue = false
	game_over = false
	dialogue_cooldown = 0.0
	dialogue_cooldown_max = 5.0

	dialogue_preset = dialogue_presets.guy
	mask_up = true
	debug_mask_disabled = false
	seen = false


	suspicion = 0.0
	suspicion_max = 5.0
	suspicion_level = sus_levels.none
	has_won = false

func open_dialogue(preset: int) :
	if dialogue_cooldown <= 0.0:
		dialogue_cooldown = dialogue_cooldown_max
		if suspicion >= suspicion_max:
			game_over = true
		dialogue = true
		dialogue_preset = preset

	
func close_dialogue():
	dialogue = false

func increase_sus_level():
	suspicion_level = suspicion_level + 1

func get_player_pos()->Vector3:
	if playerNode:
		return playerNode.global_position
	else:
		return Vector3(-1, -1, -1)
