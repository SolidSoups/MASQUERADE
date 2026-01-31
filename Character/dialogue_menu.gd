extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerStateAutoload.dialogue:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		visible = true
		get_tree().paused = true


func _on_button_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	PlayerStateAutoload.close_dialogue()
	visible = false
	get_tree().paused = false
