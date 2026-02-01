extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var LOS_ray: RayCast3D = $Detection/LOSRay
@onready var detection_cone = $Detection
@onready var body_collision: CollisionShape3D = $BodyCollision
@onready var sprite = $AnimatedSprite3D
@onready var walk_sound = $WalkSound
@onready var murmur_sound = $MurmurSound
@onready var overheard_text = $Overheard

#background chatter
var overheard_1 = "- One of my humans escaped the other day. - Oh? I hear if you take one of their toes, they're less likely to do that."
var overheard_2 = "- Had a dream the other day. That there was some ravenous monster among us, here at the ball. Crazy, right?"
var overheard_3 = "- Did you see the eyes over on the figure? Such an unnatural shade. Like a dirty puddle. "
var overheard_4 = "- How would such a creature smile with such thick lips?"
var overheard_5 = "- Such daring artistry, working with such a bestial subject. Mark my words, he's going to be famous or dead within the lunar cycle."
var overheard_6 = "- It's a perspective thing. The nose being large doesn't mean it smells well. Or good. Hah."
var overheard_7 = "- Do you ever think of visiting the humans in their natural habitat? "
var overheard_8 = "- Lord James Robert is such a kidder. Said I looked delicious and licked his lips. I swear he was salivating."
var overheard_9 = "- Do you think the art project was ethically sourced? - Hah! Like some human is walking around with half a face?"
var overheard_10 = "- Do you think humans will ever be civilized? I think it's in their nature to be savage. "
var overheard_11 = "- I hear the main difference between humans is what kind of hat their religion requires. Isn't that fascinating?"

var overheard_list = [overheard_1, overheard_2, overheard_3, overheard_4, overheard_5, overheard_6, overheard_7, overheard_8, overheard_9, overheard_10, overheard_11, ]

@export var player: CharacterBody3D
enum enemy_presets{jimbob, guy,lady}
@export var preset = enemy_presets.jimbob
@export var speed = 2.0
@export var hostile = true
@export var wanderer = true
@onready var movement_target_position: Vector3 = PlayerStateAutoload.playerNode.position

func set_ai_id(_preset: int, _speed: float, _hostile: bool, _wanderer: bool) -> void:
	preset = _preset as enemy_presets
	speed = _speed
	hostile = _hostile
	wanderer = _wanderer

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
	sprite.frame = preset
	
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	nav_agent.set_target_position(movement_target)
	

	
func _physics_process(delta: float) -> void:
	
	if rotation_degrees.dot(PlayerStateAutoload.playerNode.rotation_degrees) > 0:
		sprite.frame = preset + 3
	else:
		sprite.frame = preset
	
	print_debug(states.keys()[state])
	
	if detection_cone.overlaps_body(PlayerStateAutoload.playerNode):
		
		if hostile:
			LOS_ray.global_rotation = Vector3(0,0,0)
			LOS_ray.set_target_position((PlayerStateAutoload.get_player_pos() + Vector3(0,1,0)) - LOS_ray.global_position)
			LOS_ray.force_raycast_update()
			if !LOS_ray.is_colliding():
				state = states.chasing
		
	if state == states.idle and is_on_floor():
		overheard_list.shuffle()
		if overheard_text.text == "" and preset != enemy_presets.jimbob :
			overheard_text.text = overheard_list[1]
		
		time_to_wait = time_to_wait - delta
		
		if time_to_wait <= 0.0:
			
			overheard_text.text = ""
			
			wander = randi_range(0, 1)
			#print_debug(wander)
			if wander == 1:
				new_wander = true
				state = states.wandering
			elif wander == 0:
				pass
				
			time_to_wait = randf_range(10.0, 15.0)
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
		overheard_text.text = ""
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
		overheard_text.text = ""
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
	#print_debug(speed)
	velocity = direction * speed
	#print_debug(direction)
	look_at(nav_agent.get_next_path_position())
	rotation.x = 0
	rotation.z = 0
	
	#sound
	if state == states.idle or state == states.wandering:
		if !murmur_sound.playing:
			murmur_sound.play()
	if state == states.idle:
		walk_sound.stop()
	elif !walk_sound.playing:
		walk_sound.play()
		
	# Add the gravity.
	if not is_on_floor():
		
		velocity += get_gravity() * delta

	

	move_and_slide()
