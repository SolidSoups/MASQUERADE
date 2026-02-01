extends Area3D

@onready var sprite = $AnimatedSprite3D
@onready var grab_sound = $GrabSound
enum face_parts {eyes, ears, nose, mouth}
@export var face_part = face_parts.eyes
var grabbed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.frame = face_part


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if overlaps_body(PlayerStateAutoload.playerNode):
		if !grabbed:
			grab_sound.play()
			grabbed = true
		
		if face_part == face_parts.eyes:
			PlayerStateAutoload.eyes = true
			
		if face_part == face_parts.ears:
			PlayerStateAutoload.ears = true
			
		if face_part == face_parts.nose:
			PlayerStateAutoload.nose = true
			
		if face_part == face_parts.mouth:
			PlayerStateAutoload.mouth = true
