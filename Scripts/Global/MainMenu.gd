extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_story_pressed() -> void:
	pass # Replace with function body.


func _on_opcoes_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Config.tscn")
