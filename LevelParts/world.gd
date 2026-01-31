extends Node3D

var level_part = preload("res://LevelParts/room_template.tscn")
var level_parts: Array[Node3D] = []

func clear_parts() -> void:
	# Queue all parts for removal
	for part in level_parts:
		part.queue_free()
	level_parts.clear()

func spawn_box(pos: Vector3)-> void:
	var box = level_part.instantiate()
	add_child(box)
	box.global_position = pos
	level_parts.append(box)

func spawn_rubix() -> void:
	const y = 1
	for x in range(3):
			for z in range(3):
				spawn_box(Vector3(x, y, z))

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F:
			clear_parts()
			spawn_rubix()

