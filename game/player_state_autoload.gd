extends Node

var playerNode: CharacterBody3D = null
enum sus_levels{none, low, medium, high, exposed}
@export var suspicion = sus_levels.none

func get_player_pos()->Vector3:
	if playerNode:
		return playerNode.global_position
	else:
		return Vector3(-1, -1, -1)
