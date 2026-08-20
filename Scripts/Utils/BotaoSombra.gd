extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Mudar a cor do botão de voltar quando estiver hover
func Backsobre() -> void:
	$back.modulate = Color(0.7,0.7,0.7,0.7)
func Backexit() -> void:
	$back.modulate = Color(1,1,1,1)
func _on_back_mouse_entered() -> void:
	Backsobre()
func _on_back_mouse_exited() -> void:
	Backexit()
	
func savesobre() -> void:
	$save.modulate = Color(0.7,0.7,0.7,0.7)
func saveexit() -> void:
	$save.modulate = Color(1,1,1,1)
func _on_save_mouse_entered() -> void:
	savesobre()
func _on_save_mouse_exited() -> void:
	saveexit()
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")
