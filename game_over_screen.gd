extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerStateAutoload.reset()
	get_tree().paused = false
	Input.mouse_mode=Input.MOUSE_MODE_VISIBLE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print_debug("help")


func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_scene.tscn")
