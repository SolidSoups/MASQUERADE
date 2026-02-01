extends Node


@onready var sus_mask = $"../CanvasLayer/Control/SuspicionMask"
@onready var sus_meter =$"../CanvasLayer/Control/ProgressBar"
@onready var big_mask = $"../CanvasLayer/Control/BigMask"
@onready var eyes = $"../CanvasLayer/Control/FaceEyes"
@onready var nose = $"../CanvasLayer/Control/FaceNose"
@onready var mouth = $"../CanvasLayer/Control/FaceMouth"
@onready var ears = $"../CanvasLayer/Control/FaceEars"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#print_debug("Player is seen: " ,PlayerStateAutoload.seen)
	if !PlayerStateAutoload.mask_up and PlayerStateAutoload.seen:
		PlayerStateAutoload.suspicion += delta/10

	sus_meter.value = PlayerStateAutoload.suspicion
	if PlayerStateAutoload.dialogue_cooldown > 0.0:
		PlayerStateAutoload.dialogue_cooldown -= delta
	
	print("is mask enabled? ", PlayerStateAutoload.mask_up, ", is debug disabled on? ", PlayerStateAutoload.debug_mask_disabled)
	big_mask.frame = PlayerStateAutoload.mask_up && !PlayerStateAutoload.debug_mask_disabled
	sus_mask.frame = PlayerStateAutoload.suspicion
	eyes.frame = PlayerStateAutoload.eyes
	nose.frame = PlayerStateAutoload.nose
	mouth.frame = PlayerStateAutoload.mouth
	ears.frame = PlayerStateAutoload.ears
	pass
