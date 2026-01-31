extends Node3D

@export_group("Nodes")
@export var gen_world: Node

# Generates a random level with the size determining the rows and columns size (identical)
func generate_random_level(size: int) -> void:
	randomize()
	for x in range(size):
		for y in range(size):
			# generate a floor at the position
			if gen_world:
				gen_world.spawn_floor(x, y)

			# always spawn walls enclosing the area
			if x==0:
				gen_world.spawn_wall(x-1, y, "x")
			elif x==size-1:
				gen_world.spawn_wall(x, y, "x")
			if y==0:
				gen_world.spawn_wall(x, y-1, "z")
			elif y==size-1:
				gen_world.spawn_wall(x, y, "z")

			# Do binary tree maze generation
			var can_south = x < size-1
			var can_west = y < size-1

			if can_south and can_west:
				if randi() % 2:
					gen_world.spawn_door(x, y, "x")
					gen_world.spawn_wall(x, y, "z")
				else:
					gen_world.spawn_door(x, y, "z")
					gen_world.spawn_wall(x, y, "x")
			elif can_south:
				gen_world.spawn_door(x, y, "x")
				gen_world.spawn_wall(x, y, "z")
			elif can_west:
				gen_world.spawn_door(x, y, "z")
				gen_world.spawn_wall(x, y, "x")

			

func _ready() -> void:
	generate_random_level(3)

