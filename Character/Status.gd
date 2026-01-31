extends Node


@onready var mask = $"../CanvasLayer/Control/Mask"
@onready var eyes = $"../CanvasLayer/Control/FaceEyes"
@onready var nose = $"../CanvasLayer/Control/FaceNose"
@onready var mouth = $"../CanvasLayer/Control/FaceMouth"
@onready var ears = $"../CanvasLayer/Control/FaceEars"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	mask.frame = PlayerStateAutoload.suspicion
	eyes.frame = PlayerStateAutoload.eyes
	nose.frame = PlayerStateAutoload.nose
	mouth.frame = PlayerStateAutoload.mouth
	ears.frame = PlayerStateAutoload.ears
	pass
