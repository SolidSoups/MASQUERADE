extends Area3D

@onready var body = $".."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_overlapping_bodies().has(PlayerStateAutoload.playerNode):
		PlayerStateAutoload.open_dialogue(body.preset)
