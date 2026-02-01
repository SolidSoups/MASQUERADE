extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var collision_body = $Area3D
@onready var walk_sound = $WalkSound

var is_mask_disabled: bool = false

func _ready()->void:
	PlayerStateAutoload.playerNode = self
	add_to_group("player")

#Debug method
func set_is_mask_disabled(is_active: bool) -> void:
	PlayerStateAutoload.debug_mask_disabled = is_active


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# click to de-mask
	if Input.is_action_pressed("click_right"):
		PlayerStateAutoload.mask_up = false
	elif Input.is_action_just_released("click_right"):
		PlayerStateAutoload.mask_up = true
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction and transform to vector
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		if is_on_floor() and !walk_sound.playing:
			walk_sound.play()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		walk_sound.stop()

	move_and_slide()
	
	if collision_body.has_overlapping_areas():
		PlayerStateAutoload.seen = true
		#print_debug("the other seen: ", PlayerStateAutoload.seen)
	else:
		PlayerStateAutoload.seen = false
		
