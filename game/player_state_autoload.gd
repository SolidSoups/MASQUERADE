extends Node

var playerNode: CharacterBody3D = null
var eyes = false
var nose = false
var mouth = false
var ears = false
var dialogue = false

enum sus_levels{none, low, medium, high, exposed}
var suspicion = sus_levels.none

func open_dialogue():
	dialogue = true
	
func close_dialogue():
	dialogue = false

func increase_sus_level():
	suspicion = suspicion + 1

func get_player_pos()->Vector3:
	if playerNode:
		return playerNode.global_position
	else:
		return Vector3(-1, -1, -1)
