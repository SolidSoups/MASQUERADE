extends Node

var playerNode: CharacterBody3D = null
var eyes = false
var nose = false
var mouth = false
var ears = false
var dialogue = false
var dialogue_cooldown = 0.0
var dialogue_cooldown_max = 5.0
var mask_up = true
var seen = false

enum sus_levels{none, low, medium, high, exposed}
var suspicion = 0.0
var suspicion_max = 5.0
var suspicion_level = sus_levels.none

func _process(delta: float) -> void:
	
	clampf(suspicion,0.0,suspicion_max)
	suspicion_level = int(suspicion)

func open_dialogue():
	if dialogue_cooldown <= 0.0:
		dialogue_cooldown = dialogue_cooldown_max
		dialogue = true
	
func close_dialogue():
	dialogue = false

func increase_sus_level():
	suspicion_level = suspicion_level + 1

func get_player_pos()->Vector3:
	if playerNode:
		return playerNode.global_position
	else:
		return Vector3(-1, -1, -1)
