extends Node3D

@export_group("Nodes")
@export var gen_world: Node

# Generates a random level with the size determining the rows and columns size (identical)
func generate_random_level(size: int) -> void:
	for x in range(size):
		for y in range(size):
			# generate a floor at the position
			if gen_world:
				gen_world.spawn_floor(x, y)

			# generate each of the walls
			gen_world.spawn_wall(x, y, "x")
			gen_world.spawn_wall(x, y, "-x")
			gen_world.spawn_wall(x, y, "z")
			gen_world.spawn_wall(x, y, "-z")
			
			

func _ready() -> void:
	generate_random_level(3)

