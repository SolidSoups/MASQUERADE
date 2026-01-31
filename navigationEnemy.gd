extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var LOS_ray: RayCast3D = $Detection/LOSRay
@onready var detection_cone = $Detection
@onready var body_collision: CollisionShape3D = $BodyCollision
@export var player: CharacterBody3D
@export var speed = 2.0
@export var hostile = true
@export var wanderer = true
@onready var movement_target_position: Vector3 = PlayerStateAutoload.playerNode.position

enum states{idle, chasing, looking, wandering}
var state = states.idle
var time_to_wait = randf_range(5.0, 10.0)
var wander = randi_range(0,1)
var new_wander = true
var direction = Vector3.DOWN

func _ready():
	actor_setup.call_deferred()
	
	
func actor_setup():
	await get_tree().physics_frame
	
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	nav_agent.set_target_position(movement_target)
	

	
func _physics_process(delta: float) -> void:
	

	
	print_debug(states.keys()[state])
	
	if detection_cone.overlaps_body(PlayerStateAutoload.playerNode):
		
		if hostile:
			LOS_ray.global_rotation = Vector3(0,0,0)
			LOS_ray.set_target_position((PlayerStateAutoload.get_player_pos() + Vector3(0,1,0)) - LOS_ray.global_position)
			LOS_ray.force_raycast_update()
			if !LOS_ray.is_colliding():
				state = states.chasing
		
	if state == states.idle and is_on_floor():
		#print_debug("wait",time_to_wait)
		time_to_wait = time_to_wait - delta
		
		if time_to_wait <= 0.0:

			wander = randi_range(0, 1)
			#print_debug(wander)
			if wander == 1:
				new_wander = true
				state = states.wandering
			elif wander == 0:
				pass
				
			time_to_wait = randf_range(5.0, 10.0)
		#print_debug(state)
		
	if state == states.wandering:
		if !wanderer:
			state = states.idle
			return
		if new_wander:
			nav_agent.target_position = NavigationServer3D.map_get_random_point(nav_agent.get_navigation_map(),1,0)
			new_wander = false
		
		
		if nav_agent.distance_to_target() <= nav_agent.target_desired_distance:
			
			direction = Vector3.ZERO
			state = states.idle
		else:
			direction = (nav_agent.get_next_path_position() - global_position).normalized()
		#print_debug("wandering")
		
	if state == states.looking:
		#nav_agent.target_position = nav_agent.get_final_position()
		#print_debug(nav_agent.distance_to_target())
		#print_debug(nav_agent.is_navigation_finished())
		if nav_agent.distance_to_target() <= nav_agent.target_desired_distance:
			#print_debug("Done looking")
			direction = Vector3.ZERO
			state = states.idle
		else:
			direction = (nav_agent.get_next_path_position() - global_position).normalized()
	if state == states.chasing:
		#print_debug("chasing")
		LOS_ray.global_rotation = Vector3(0,0,0)
		LOS_ray.set_target_position((PlayerStateAutoload.get_player_pos() + Vector3(0,1,0)) - LOS_ray.global_position)
		LOS_ray.force_raycast_update()
		
		if !LOS_ray.is_colliding() :
			#print_debug(LOS_ray.get_collider())
			
			nav_agent.target_position = PlayerStateAutoload.playerNode.position
			direction = (nav_agent.get_next_path_position() - global_position).normalized()
			
			
		else:
			state = states.looking
	print_debug(speed)
	velocity = direction * speed
	#print_debug(direction)
	look_at(nav_agent.get_next_path_position())
	rotation.x = 0
	rotation.z = 0
	# Add the gravity.
	if not is_on_floor():
		
		velocity += get_gravity() * delta

	

	move_and_slide()
