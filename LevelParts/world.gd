extends Node3D

@export_group("Nodes")
@export var gen_world: Node
@export var gen_map: Node
@export var character_controller: PackedScene
@export var enemy: PackedScene

# Generates a random level with the size determining the rows and columns size (identical)
func generate_random_level() -> void:
	randomize()
	gen_map.init()
	gen_map.generate()
	
	var w = gen_map.width
	var h = gen_map.height

	print("width: %d, height %d" % [w, h])

	var wall_count := 0
	
	for x in range(w):
		for y in range(h):
			var is_room: bool = gen_map.is_room(x, y)

			if is_room:
				gen_world.spawn_room_floor(x, y)
				gen_world.spawn_room_ceiling(x, y)
			else:
				gen_world.spawn_floor(x, y)
			
			# Boundary -x / -z
			if x == 0:
				if is_room:
					gen_world.spawn_room_wall(x - 1, y, "x")
				else:
					gen_world.spawn_wall(x - 1, y, "x")
				wall_count += 1
			if x == w - 1:
				if is_room:
					gen_world.spawn_room_wall(x, y, "x")
				else:
					gen_world.spawn_wall(x, y, "x")
				wall_count += 1
			if y == 0:
				if is_room:
					gen_world.spawn_room_wall(x, y-1, "z")
				else:
					gen_world.spawn_wall(x, y - 1, "z")
				wall_count += 1
			if y == h - 1:
				if is_room:
					gen_world.spawn_room_wall(x, y, "z")
				else:
					gen_world.spawn_wall(x, y, "z")
				wall_count += 1

			var is_x_room: bool = gen_map.is_room(x + 1, y)
			var is_z_room: bool = gen_map.is_room(x, y + 1)
			
			# +x side
			if x == w - 1:
				if is_room or is_x_room:
					gen_world.spawn_room_wall(x, y, "x")
				else:
					gen_world.spawn_wall(x, y, "x")
			elif gen_map.has_wall_x(x, y):
				if is_room or is_x_room:
					gen_world.spawn_room_wall(x, y, "x")
				else:
					gen_world.spawn_wall(x, y, "x")
			else:
				if is_room or is_x_room:
					gen_world.spawn_room_door(x, y, "x")
				else:
					gen_world.spawn_door(x, y, "x")

			# +z side
			if y == h - 1:
				if is_room or is_z_room:
					gen_world.spawn_room_wall(x, y, "z")
				else:
					gen_world.spawn_wall(x, y, "z")
			elif gen_map.has_wall_z(x, y):
				if is_room or is_z_room:
					gen_world.spawn_room_wall(x, y, "z")
				else:
					gen_world.spawn_wall(x, y, "z")
			else:
				if is_room or is_z_room:
					gen_world.spawn_room_door(x, y, "z")
				else:
					gen_world.spawn_door(x, y, "z")
					
	
	var spawn_x = roundi(w / 2.0)
	var spawn_y = roundi(h / 2.0)
	gen_world.spawn_spawn_floor(spawn_x, spawn_y)

func _ready() -> void:
	# Generate world and bake navigation
	generate_random_level()
	gen_world.bake_navigation_async()

	#Spawn player
	var newPlayer = character_controller.instantiate()
	add_child(newPlayer)
	newPlayer.global_position = gen_world.get_spawn_pos() + Vector3(0, 0.2,0)

	#Spawn test enemy
	# var new_enemy = enemy.instantiate()
	# add_child(new_enemy)
	# new_enemy.global_position = gen_world.get_spawn_pos() + Vector3(2, 0.2, 0)
