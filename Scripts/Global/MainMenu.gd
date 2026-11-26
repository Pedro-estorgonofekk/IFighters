extends TextureRect

func _on_story_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scenarios/FightScene.tscn")
static var volumes_iniciados := false
func _ready() -> void:
	$VBoxContainer/Versus.grab_focus()
	if not volumes_iniciados:
		volumes_iniciados = true	
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(0.7))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(0.6))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(0.3))
		
func _on_opcoes_pressed():
	if not has_node("Options"):
		var tela = config.instantiate()
		tela.name = "Options"
		add_child(tela)
		get_tree().paused = true
const config := preload("res://Scenes/UI/Options.tscn")
const credito := preload("res://Scenes/UI/creditos.tscn")
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
	get_tree().change_scene_to_file("res://Scenes/UI/SelectionPlayer.tscn")
	
var exit_screen_scene = preload("res://Scenes/UI/ExitScreen.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Sair"):
		if not has_node("ExitScreen"):
			var tela = preload("res://Scenes/UI/ExitScreen.tscn").instantiate()
			add_child(tela)
		else:
			get_node("ExitScreen").queue_free()


func _on_creditos_pressed() -> void:
	if not has_node("Creditos"):
		var opt = credito.instantiate()
		opt.name = "Creditos"
		add_child(opt)
		get_tree().paused = true
