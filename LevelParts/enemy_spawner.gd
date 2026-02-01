extends Node3D

@export_group("Enemies")
@export var enemy_scene: PackedScene = null
@export var room_radius: float = 4
@export_group("Passive Settings")
@export var passive_groups: int = 4
@export var group_size_min: int = 2
@export var group_size_max: int = 6
@export_group("Chaser settings")
@export var chaser_group_size_min: int = 1
@export var chaser_group_size_max: int = 2


func spawn_passive(spawn_pos: Vector3)->void:
	var final_x: float = randf_range(-room_radius, room_radius)
	var final_y: float =  randf_range(-room_radius, room_radius)

	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = spawn_pos + Vector3(final_x, 0.2, final_y)

func spawn_chaser(spawn_pos: Vector3)->void:
	var final_x: float = randf_range(-room_radius, room_radius)
	var final_y: float = randf_range(-room_radius, room_radius)

	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = spawn_pos + Vector3(final_x, 0.2, final_y)
	print("Spawned chaser at ", spawn_pos)

func spawn_boss(pos: Vector3)->void:
	print("Spawned boss at %s" % [pos])

func spawn_all_enemies(gen_map: Node, gen_world: Node)->void:
	var w: int = gen_map.width
	var h: int = gen_map.height

	# First pass, spawn random passive enemies
	for i in range(passive_groups):
		var rx: int = randi_range(1, w-2)
		var ry: int = randi_range(1, h-2)
		var rgroup_size: int = randi_range(group_size_min, group_size_max)

		var spawn_pos = gen_world.get_cell_pos_global(rx, ry)

		#Spawn all enemies in group
		for enemy in range(rgroup_size):
			spawn_passive(spawn_pos)	

func spawn_chasers(gen_map: Node, gen_world: Node, positions: Array[Vector2i]) -> void:
	var w: int = gen_map.height
	var h: int = gen_map.width

	for interest in positions:
		# Spawn chasers closeby to targets	
		var ix: int= position.x
		var iy: int= position.y
		var rx : int = randi_range(1, 2)
		var ry : int = randi_range(1, 2)
		var group_size: int = randi_range(chaser_group_size_min, chaser_group_size_max)

		var spawn_pos = gen_world.get_cell_pos_global(ix + rx, iy + ry)
		for i in range(group_size):
			spawn_chaser(spawn_pos)	


			
		



	



