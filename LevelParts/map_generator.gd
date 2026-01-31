extends Node3D

@export_group("Settings")
@export var width: int = 10
@export var height: int = 10
@export_range(0.0, 1.0) var room_chance: float = 0.2

enum Tag { DEFAULT, GARDEN, ROOM }

var wall_x: Array[bool] = []
var wall_z: Array[bool] = []
var tags: Array[int] = []

func in_bounds(x: int, y: int)->bool:
	return y * width + x < width * height

#Set size of the maze
func init()->void:
	wall_x.resize(width * height)
	wall_z.resize(width * height)
	tags.resize(width * height)
	wall_x.fill(true)
	wall_z.fill(true)
	tags.fill(0)

#Generate a maze on the set size
func generate()->void:
	if width < 0 or height < 0:
		return

	for y in height:
		for x in width:
			var can_x = x < width - 1
			var can_z = x < height - 1
			if can_x and can_z:
				if randi() % 2:
					wall_x[y * width + x] = false
				else:
					wall_z[y * width + x] = true
			elif can_x:
				wall_x[y * width + x] = false
			elif can_z:
				wall_z[y * width + x] = false
	_tag_rooms()

func _tag_rooms():
	var cells := []
	for i in tags.size():
		cells.append(i)
	cells.shuffle()

	var room_count = ceili(width * height * room_chance)
	var tagged := 0

	for i in cells:
		if tagged >= room_count:
			break
		if tags[i] != Tag.GARDEN:
			continue
		var x = i % width
		var y = i / width
		tagged += _flood_tag(x, y, Tag.ROOM, randi_range(2, 5))
	
func _flood_tag(sx: int, sy: int, tag: Tag, count: int) -> int:
	var stack := [Vector2i(sx, sy)]
	var filled := 0

	while stack and filled < count:
		var cell = stack.pop_back()
		var x = cell.x
		var y = cell.y
		if not in_bounds(x, y):
			continue
		if tags[y * width + x] != Tag.GARDEN:
			continue

		tags[y * width + x] = tag
		filled += 1

		var neighbours: Array[Vector2i] = []
		if x < width - 1 and not wall_x[y * width + x]:
			neighbours.append(Vector2i(x + 1, y))
		if x > 0 and not wall_x[y * width + (x - 1)]:
			neighbours.append(Vector2i(x-1, y))
		if y < height -1 and not wall_z[y * width + x]:
			neighbours.append(Vector2i(x, y+1))
		if y > 0 and not wall_z[(y - 1) * width + x]:
			neighbours.append(Vector2i(x, y - 1))

		neighbours.shuffle()
		stack.append_array(neighbours)
	
	return filled



func has_wall_x(x: int, y: int) -> bool:
	return wall_x[y * width + x]

func has_wall_z(x: int, y: int) -> bool:
	return wall_z[y * width + x]

func is_room(x: int, y: int) -> bool:
	return tags[y * width + x] == Tag.ROOM


