extends Node3D

@export_group("Nodes")
@export var gen_world: Node
@export var gen_map: Node
@export var character_controller: PackedScene
@export var enemy: PackedScene

# Generates a random level with the size determining the rows and columns size (identical)
func generate_random_level(size: int) -> void:
	randomize()
	gen_map.init()
	gen_map.generate()
	for x in range(gen_map.width):
		for y in range(gen_map.height):
			# generate a floor at the position
			gen_world.spawn_floor(x, y)
			var is_this_room: bool = gen_map.is_room(x, y)
			if is_this_room:
				gen_world.spawn_room_ceiling(x, y)

			# always spawn walls enclosing the area
			if x==0:
				gen_world.spawn_wall(x-1, y, "x")
			elif x==size-1:
				gen_world.spawn_wall(x, y, "x")
			if y==0:
				gen_world.spawn_wall(x, y-1, "z")
			elif y==size-1:
				gen_world.spawn_wall(x, y, "z")
			
			var is_x_room = gen_map.is_room(x+1, y)
			var is_z_room = gen_map.is_room(x, y+1)
			if gen_map.has_wall_x(x, y):
				if is_this_room or is_x_room:
					gen_world.spawn_room_wall(x, y, "x")
				else:
					gen_world.spawn_wall(x, y, "x")
			else:
				if is_this_room or is_x_room:
					gen_world.spawn_room_
				gen_world.spawn_door(x, y, "x")
			if gen_map.has_wall_z(x, y):
				gen_world.spawn_wall(x, y, "z")
			else:
				gen_world.spawn_door(x, y, "z")


	# finally set the spawn floor so we can get it in script
	var spawn_adjusted = roundi(size / 2.0)
	gen_world.spawn_spawn_floor(spawn_adjusted, spawn_adjusted)

func _ready() -> void:
	# Generate world and bake navigation
	generate_random_level(4)
	gen_world.bake_navigation_async()

	#Spawn player
	var newPlayer = character_controller.instantiate()
	add_child(newPlayer)
	newPlayer.global_position = gen_world.get_spawn_pos() + Vector3(0, 0.2,0)

	#Spawn test enemy
	var new_enemy = enemy.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = gen_world.get_spawn_pos() + Vector3(2, 0.2, 0)
