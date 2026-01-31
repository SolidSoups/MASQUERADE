class_name GeneratedWorld
extends Node3D

@export_group("Nodes")
@export var floor_gridMap: GridMap
@export var wallx_gridMap: GridMap
@export var wallz_gridMap: GridMap

const FLOOR_INDEX: int = 0
const WALLX_INDEX: int = 1
const WALLZ_INDEX: int = 2
const WALLX_DOOR_INDEX: int = 3
const WALLZ_DOOR_INDEX: int = 4

func spawn_floor(x: int, y: int)->void:
	floor_gridMap.set_cell_item(Vector3i(x, 0, y), FLOOR_INDEX)	

func spawn_wall(x: int, y: int, direction: String):
	var pos3 = Vector3i(x, 0, y)
	if direction == "x":
		wallx_gridMap.set_cell_item(pos3, WALLX_INDEX)
	elif direction == "z":
		wallz_gridMap.set_cell_item(pos3, WALLZ_INDEX )

func spawn_door(x: int, y: int, direction: String):
	var pos3 = Vector3i(x, 0, y)
	if direction == "x":
		wallx_gridMap.set_cell_item(pos3, WALLX_DOOR_INDEX)
	elif direction == "z":
		wallz_gridMap.set_cell_item(pos3, WALLZ_DOOR_INDEX )
