class_name GeneratedWorld
extends Node3D

@export_group("Nodes")
@export var floor_gridMap: GridMap
@export var wallx_gridMap: GridMap
@export var wallz_gridMap: GridMap
@export var ceiling_gridMap: GridMap
@export var nav_mesh: NavigationRegion3D

const FLOOR_INDEX: int = 0
const ROOM_CEILING_INDEX: int = 1
const ROOM_FLOOR_INDEX: int = 2
const SPAWN_FLOOR_INDEX: int = 3
const WALLX_INDEX: int = 4
const WALLX_DOOR_INDEX: int = 5
const WALLZ_INDEX: int = 6
const WALLZ_DOOR_INDEX: int = 7
const ROOM_WALLX_INDEX: int = 8
const ROOM_WALLX_DOOR_INDEX: int = 9
const ROOM_WALLZ_INDEX: int = 10
const ROOM_WALLZ_DOOR_INDEX: int = 11

func bake_navigation_async()->void:
	nav_mesh.bake_navigation_mesh(true)
	nav_mesh.bake_finished.connect(_on_bake_done)

func _on_bake_done():
	print("Nav mesh baking finished!")

func spawn_floor(x: int, y: int)->void:
	floor_gridMap.set_cell_item(Vector3i(x, 0, y), FLOOR_INDEX)	
func spawn_room_floor(x: int, y: int)->void:
	floor_gridMap.set_cell_item(Vector3i(x, 0, y), ROOM_FLOOR_INDEX)
func spawn_spawn_floor(x: int, y: int)->void:
	floor_gridMap.set_cell_item(Vector3i(x, 0, y), SPAWN_FLOOR_INDEX)
func spawn_room_ceiling(x: int, y: int)->void:
	ceiling_gridMap.set_cell_item(Vector3i(x, 0, y), ROOM_CEILING_INDEX)

func spawn_wall(x: int, y: int, direction: String):
	var pos3 = Vector3i(x, 0, y)
	if direction == "x":
		wallx_gridMap.set_cell_item(pos3, WALLX_INDEX)
	elif direction == "z":
		wallz_gridMap.set_cell_item(pos3, WALLZ_INDEX )
func spawn_room_wall(x: int, y: int, direction: String):
	var pos3 = Vector3i(x, 0, y)
	if direction == "x":
		wallx_gridMap.set_cell_item(pos3, ROOM_WALLX_INDEX)
	elif direction == "z":
		wallz_gridMap.set_cell_item(pos3, ROOM_WALLZ_INDEX)

func spawn_door(x: int, y: int, direction: String):
	var pos3 = Vector3i(x, 0, y)
	if direction == "x":
		wallx_gridMap.set_cell_item(pos3, WALLX_DOOR_INDEX)
	elif direction == "z":
		wallz_gridMap.set_cell_item(pos3, WALLZ_DOOR_INDEX )
func spawn_room_door(x: int, y: int, direction: String):
	var pos3 = Vector3i(x, 0, y)
	if direction == "x":
		wallx_gridMap.set_cell_item(pos3, ROOM_WALLX_DOOR_INDEX)
	elif direction == "z":
		wallz_gridMap.set_cell_item(pos3, ROOM_WALLZ_DOOR_INDEX)



func get_spawn_pos()->Vector3:
	var floors := []
	for cell in floor_gridMap.get_used_cells():
		if floor_gridMap.get_cell_item(cell) == SPAWN_FLOOR_INDEX:
			floors.append(cell)
	if floors.size() == 0:
		return Vector3.ZERO
	return floor_gridMap.map_to_local(floors[randi() % floors.size()])

func get_cell_pos(x: int, y: int)->Vector3:
	return floor_gridMap.map_to_local(Vector3i(x, 0, y))

func get_cell_pos_global(x: int, y: int) -> Vector3:
	return floor_gridMap.to_global(floor_gridMap.map_to_local(Vector3(x, 0, y)))

func world_to_grid(pos: Vector3) -> Vector2i:
	var local = floor_gridMap.to_local(pos)
	var cell = floor_gridMap.local_to_map(local)
	return Vector2i(cell.x, cell.z)
