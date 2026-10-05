extends TextureRect

func _on_story_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scenarios/FightScene.tscn")


func _on_opcoes_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Config.tscn")

#Botao Versus Shadow
func _on_versus_focus_entered() -> void:
	$VBoxContainer/Versus.modulate.a = 0.6
func _on_versus_mouse_entered() -> void:
	$VBoxContainer/Versus.modulate.a = 0.6
func _on_versus_focus_exited() -> void:
	$VBoxContainer/Versus.modulate.a = 1
func _on_versus_mouse_exited() -> void:
	$VBoxContainer/Versus.modulate.a = 1
	
#Botao Creditos Shadow
func _on_creditos_focus_entered() -> void:
	$VBoxContainer/Creditos.modulate.a = 0.6
func _on_creditos_mouse_entered() -> void:
	$VBoxContainer/Creditos.modulate.a = 0.6
func _on_creditos_focus_exited() -> void:
	$VBoxContainer/Creditos.modulate.a = 1
func _on_creditos_mouse_exited() -> void:
	$VBoxContainer/Creditos.modulate.a = 1

func _on_opcoes_focus_entered() -> void:
	$VBoxContainer/Opcoes.modulate.a = 0.6
func _on_opcoes_mouse_entered() -> void:
	$VBoxContainer/Opcoes.modulate.a = 0.6
func _on_opcoes_focus_exited() -> void:
	$VBoxContainer/Opcoes.modulate.a = 1
func _on_opcoes_mouse_exited() -> void:
	$VBoxContainer/Opcoes.modulate.a = 1


func _on_versus_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scenarios/FightScene.tscn")
