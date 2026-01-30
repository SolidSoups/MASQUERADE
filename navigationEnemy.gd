extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@export var player: CharacterBody3D
@export var speed = 2.0
@onready var movement_target_position: Vector3 = player.position
var direction = Vector3.FORWARD
func _ready():
	nav_agent.path_desired_distance = 1.0
	nav_agent.target_desired_distance = 0.5
	
	actor_setup.call_deferred()
	
func actor_setup():
	await get_tree().physics_frame
	
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	nav_agent.set_target_position(movement_target)
	
func _physics_process(delta: float) -> void:
	
	nav_agent.target_position = player.position
	direction = (nav_agent.get_next_path_position() - global_position).normalized()
	print_debug(direction)
	velocity = direction * speed
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	

	move_and_slide()
