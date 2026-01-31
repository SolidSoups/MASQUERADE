extends Node

var playerNode: CharacterBody3D

func get_player_pos()->Vector3:
	if playerNode:
		return playerNode.global_position
	else:
		return Vector3(-1, -1, -1)
