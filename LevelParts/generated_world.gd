class_name GeneratedWorld
extends Node3D

@export_group("Nodes")
@export var floor_gridMap: GridMap
@export var wallx_gridMap: GridMap
@export var wallz_gridMap: GridMap
@export var nav_mesh: NavigationRegion3D

const FLOOR_INDEX: int = 0
const SPAWN_FLOOR_INDEX: int = 1
const WALLX_INDEX: int = 2
const WALLZ_INDEX: int = 3
const WALLX_DOOR_INDEX: int = 4
const WALLZ_DOOR_INDEX: int = 5

func bake_navigation_async()->void:
	nav_mesh.bake_navigation_mesh(true)
	nav_mesh.bake_finished.connect(_on_bake_done)

func _on_bake_done():
	print("Nav mesh baking finished!")

func spawn_floor(x: int, y: int)->void:
	floor_gridMap.set_cell_item(Vector3i(x, 0, y), FLOOR_INDEX)	
func spawn_spawn_floor(x: int, y: int)->void:
	floor_gridMap.set_cell_item(Vector3i(x, 0, y), SPAWN_FLOOR_INDEX)
func get_spawn_pos()->Vector3:
	var floors := []
	for cell in floor_gridMap.get_used_cells():
		if floor_gridMap.get_cell_item(cell) == SPAWN_FLOOR_INDEX:
			floors.append(cell)
	if floors.size() == 0:
		return Vector3.ZERO
	return floor_gridMap.map_to_local(floors[randi() % floors.size()])


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
