extends Node3D

func spawn_passive(pos: Vector3)->void:
	print("Spawned passive at %p" % [pos])

func spawn_sus(pos: Vector3)->void:
	print("Spawned sussy baka at %p" % [pos])

func spawn_boss(pos: Vector3)->void:
	print("Spawned boss at %p" % [pos])

func spawn_all_enemies(gen_map: Node, gen_world: Node)->void:
	var w: int = gen_map.width
	var h: int = gen_map.height

	# First pass, spawn random passive enemies
	const passive_groups := 4
	const group_size_min := 2
	const group_size_max := 6
	const room_radius := 4
	for i in range(passive_groups):
		var rx: int = randi_range(0, w-1)
		var ry: int = randi_range(0, h-1)
		var rgroup_size: int = randi_range(group_size_min, group_size_max)

		var spawn_pos = gen_world.get_cell_pos_global(rx, ry)

		#Spawn all enemies in group
		for enemy in range(rgroup_size):
			var final_x = rx + randi_range(-room_radius, room_radius)
			var final_y = ry + randi_range(-room_radius, room_radius)
			spawn_passive(Vector3(final_x, 0.2, final_y))	
				
		



	



