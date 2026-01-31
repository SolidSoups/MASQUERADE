extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var LOS_ray: RayCast3D = $Detection/LOSRay
@onready var detection_cone = $Detection
@export var player: CharacterBody3D
@export var speed = 2.0
@onready var movement_target_position: Vector3 = player.position
enum states{idle, chasing, looking, wandering}
var state = states.idle
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
	
	state = states.chasing
	
	if state == states.chasing:
		LOS_ray.global_rotation = Vector3(0,0,0)
		LOS_ray.set_target_position((player.global_position + Vector3(0,1,0)) - LOS_ray.global_position)
		LOS_ray.force_raycast_update()
		
		if   !LOS_ray.is_colliding() :
			print_debug(LOS_ray.get_collider())
			nav_agent.target_position = player.position
			direction = (nav_agent.get_next_path_position() - global_position).normalized()
			
			velocity = direction * speed
			look_at(player.position)
			rotation.x = 0
			rotation.z = 0
		else:
			direction = Vector3.ZERO
			velocity = direction * speed
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	

	move_and_slide()
