extends CanvasLayer

@onready var big_mask = $"../CanvasLayer/Control/BigMask"
@onready var talkee = $Control/AnimatedSprite2D
@onready var dialogue_box = $Label
@onready var button_1 = $BoxContainer/Button1
var button_1_sus = 0
@onready var button_2 = $BoxContainer/Button2
var button_2_sus = 0
@onready var button_3 = $BoxContainer/Button3
var button_3_sus = 0

#Jimbob convos
var jimbob_convo_1 = "James will have a little lamb. *licks lips* I'm James."
var jimbob_convo_1_ans_no_sus = ["Teehee. Hi, James.",1]
var jimbob_convo_1_ans_mild = ["Sup, Jim. I'm just mutton around.",2]
var jimbob_convo_1_ans_very = ["James. Can you help me get out of here, James?",3]

var jimbob_convo_2 = "James Robert BonVivant. You're charmed, I'm sure. Have we met?"
var jimbob_convo_2_ans_no_sus = ["Maybe in our dreams?",1]
var jimbob_convo_2_ans_mild = ["I think I'd remember meeting a psy... siren... such as yourself.",2]
var jimbob_convo_2_ans_very = ["You wouldn't recognize me even if we had. My face is gone.",3]

var jimbob_convo_3 = "I don't believe I've had the pleasure. James Robert, and you are?"
var jimbob_convo_3_ans_no_sus = ["Who can remember, James? I'm here.",1]
var jimbob_convo_3_ans_mild = ["Your name is Jim-bob? Seriously?",2]
var jimbob_convo_3_ans_very = ["Oh, I'm nobody. Definitely nobody interesting. Certainly not an art project",3]

#innocent convos
var inno_convo_1 = "What a lovely mask. One does get so tired of the basic vulpine, accipitrine, serpentine."
var inno_convo_1_ans_no_sus = ["I'm a rebel.",0]
var inno_convo_1_ans_mild = ["How can I get out of here?",0.5]
var inno_convo_1_ans_very = ["I'm vul-pining for my face... because it's missing. Have you seen my face?",1]

var inno_convo_2 = "Well, hello, little lamb. Have you lost your shepherd?"
var inno_convo_2_ans_no_sus = ["Baaa.",0]
var inno_convo_2_ans_mild = ["Are you offering to shear me?",0.5]
var inno_convo_2_ans_very = ["What the hell is wrong with you people!?",1]

var inno_convo_3 = "Hey. Nice party, huh? God, I hate everyone here. How about you?"
var inno_convo_3_ans_no_sus = ["I mean, not everyone...",0]
var inno_convo_3_ans_mild = ["Well, I definitely hate you.",0.5]
var inno_convo_3_ans_very = ["I'm having all the emotions. Hate, fear, wanting to find my face.",1]

var inno_convo_4 = "Are you a servant? I need a refill."
var inno_convo_4_ans_no_sus = ["I'll be happy to get you a refill.",0]
var inno_convo_4_ans_mild = ["Absolutely, does the serving quarters have an exit?",0.5]
var inno_convo_4_ans_very = ["Oh, my god! My eyes are gone! My mouth is gone! How am I even speaking?!",1]

#sus convos
var sus_convo_1 = "You seem a little lost. Is this your first party?"
var sus_convo_1_ans_no_sus = ["Yes. And I seem to have lost my escort.",0.5]
var sus_convo_1_ans_mild = ["No. I've been to lots of parties. I'm just used to having more face, uh, time.",1]
var sus_convo_1_ans_very = ["This doesn't seem like a party. You people stole my goddamn face!",2]

var sus_convo_2 = "Did you just come from one of the forbidden areas? You're not supposed to be back there.?"
var sus_convo_2_ans_no_sus = ["Sorry. It's been a long night and I didn't feel like going around.",0.5]
var sus_convo_2_ans_mild = ["Yeah. I know... the owner... or the artist... or whatever. They're okay with it.",1]
var sus_convo_2_ans_very = ["Who the fuck are you to tell me where to go, you faceless monster?",2]

var sus_convo_3 = "You seem a bit altered, and not in the good way."
var sus_convo_3_ans_no_sus = ["Too much wine, not enough cheese. You know what I mean?",0.5]
var sus_convo_3_ans_mild = ["Yeah. I can't feel my face. Probably need to find the bathroom.",1]
var sus_convo_3_ans_very = ["Could be worse. My nose could be gushing blood. *snap teeth near their face*",2]

var sus_convo_4 = "Your mask is unusual. Where did you get it?"
var sus_convo_4_ans_no_sus = ["It's a special mask. Because I'm special.",0.5]
var sus_convo_4_ans_mild = ["I just found it lying around. I forgot my other one.",1]
var sus_convo_4_ans_very = ["Well, I had to cover my lack of face somehow.",2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerStateAutoload.dialogue:
		if PlayerStateAutoload.dialogue_preset == 0:
			get_jimbob_bialogue()
			PlayerStateAutoload.dialogue = false
		else:
			get_normal_dialogue()
			PlayerStateAutoload.dialogue = false
		talkee.frame = PlayerStateAutoload.dialogue_preset
		big_mask.frame = 0
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		visible = true
		get_tree().paused = true

func get_normal_dialogue():
	if PlayerStateAutoload.suspicion < PlayerStateAutoload.suspicion_max/2:
		var rand = randi_range(0,3)
		var list
		if rand == 0:
			dialogue_box.text = inno_convo_1
			list = [inno_convo_1_ans_mild,inno_convo_1_ans_no_sus,inno_convo_1_ans_very]
		elif rand == 1:
			dialogue_box.text = inno_convo_2
			list = [inno_convo_2_ans_mild,inno_convo_2_ans_no_sus,inno_convo_2_ans_very]
			
		elif rand == 2:
			dialogue_box.text = inno_convo_3
			list = [inno_convo_3_ans_mild,inno_convo_3_ans_no_sus,inno_convo_3_ans_very]
		
		else:
			dialogue_box.text = inno_convo_4
			list = [inno_convo_4_ans_mild,inno_convo_4_ans_no_sus,inno_convo_4_ans_very]

		list.shuffle()
		button_1.text = list[0][0]
		button_1_sus =list[0][1]

		button_2.text = list[1][0]
		button_2_sus =list[1][1]
		
		button_3.text = list[2][0]
		button_3_sus =list[2][1]
		
	elif PlayerStateAutoload.suspicion > PlayerStateAutoload.suspicion_max/2:
		var rand = randi_range(0,3)
		var list
		if rand == 0:
			dialogue_box.text = sus_convo_1
			list = [sus_convo_1_ans_mild,sus_convo_1_ans_no_sus,sus_convo_1_ans_very]
		elif rand == 1:
			dialogue_box.text = sus_convo_2
			list = [sus_convo_2_ans_mild,sus_convo_2_ans_no_sus,sus_convo_2_ans_very]
			
		elif rand == 2:
			dialogue_box.text = inno_convo_3
			list = [sus_convo_3_ans_mild,sus_convo_3_ans_no_sus,sus_convo_3_ans_very]
		
		else:
			dialogue_box.text = sus_convo_4
			list = [sus_convo_4_ans_mild,sus_convo_4_ans_no_sus,sus_convo_4_ans_very]

		list.shuffle()
		button_1.text = list[0][0]
		button_1_sus =list[0][1]

		button_2.text = list[1][0]
		button_2_sus =list[1][1]
		
		button_3.text = list[2][0]
		button_3_sus =list[2][1]

func get_jimbob_bialogue():
	var rand = randi_range(0,2)
	var list
	if rand == 0:
		dialogue_box.text = jimbob_convo_1
		list = [jimbob_convo_1_ans_mild,jimbob_convo_1_ans_no_sus,jimbob_convo_1_ans_very]
	elif rand == 1:
		dialogue_box.text = jimbob_convo_2
		list = [jimbob_convo_2_ans_mild,jimbob_convo_2_ans_no_sus,jimbob_convo_2_ans_very]
		
	else:
		dialogue_box.text = jimbob_convo_2
		list = [jimbob_convo_3_ans_mild,jimbob_convo_3_ans_no_sus,jimbob_convo_3_ans_very]

	list.shuffle()
	button_1.text = list[0][0]
	button_1_sus =list[0][1]

	button_2.text = list[1][0]
	button_2_sus =list[1][1]
	
	button_3.text = list[2][0]
	button_3_sus =list[2][1]

func _on_button_pressed() -> void:
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	PlayerStateAutoload.close_dialogue()
	PlayerStateAutoload.mask_up
	PlayerStateAutoload.suspicion += button_1_sus * 0.5
	visible = false
	get_tree().paused = false


func _on_button_2_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	PlayerStateAutoload.close_dialogue()
	PlayerStateAutoload.mask_up
	PlayerStateAutoload.suspicion += button_2_sus * 0.5
	visible = false
	get_tree().paused = false


func _on_button_3_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	PlayerStateAutoload.close_dialogue()
	PlayerStateAutoload.mask_up
	PlayerStateAutoload.suspicion += button_3_sus * 0.5
	visible = false
	get_tree().paused = false
