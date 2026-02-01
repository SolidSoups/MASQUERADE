extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body)->void:
	var label = Label.new()
	label.text = "YOU WIN!"
	add_child(label)
