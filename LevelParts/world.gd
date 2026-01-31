extends Node3D

@export_group("Parts")
@export var fountain_part: PackedScene
@export var wall_part: PackedScene
@export var doorwall_part: PackedScene

var wall_positions: Array[Vector3] = [
	Vector3(7.5, 0, 0), 
	Vector3(-7.5, 0, 0), 
	Vector3(0, 0, 7.5), 
	Vector3(0, 0, -7.5)
]
var wall_yrotations: Array[float] = [90.0, 90.0, 0, 0]

# spawn a level surrounded by walls
func spawn_level(level: PackedScene):
	var spwnLvl = level.instantiate()	
	add_child(spwnLvl)
	spwnLvl.global_position = Vector3(0, 0, 0)

	# Spawn walls all around	
	for r in range(4):
		var newWall: Node3D
		if randf() < 0.3:
			newWall = doorwall_part.instantiate()
		else:
			newWall = wall_part.instantiate()
		spwnLvl.add_child(newWall)
		newWall.global_position = wall_positions[r]
		newWall.rotation_degrees = Vector3(0, wall_yrotations[r], 0)


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F:
			spawn_level(fountain_part)

