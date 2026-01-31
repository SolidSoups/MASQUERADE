extends CSGBox3D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# create new material
	var new_material = StandardMaterial3D.new()
	new_material.albedo_color = Color(rng.randf_range(0.0, 1.0), rng.randf_range(0.0, 1.0), rng.randf_range(0.0, 1.0))
	new_material.metallic = 0.5
	new_material.roughness = 0.1

	# apply material
	self.material = new_material
