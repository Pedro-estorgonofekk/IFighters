extends ColorRect

var options = preload("res://Scenes/UI/Options.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect/VBoxContainer/Continuar.grab_focus()
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true

func _unhandled_input(event: InputEvent) -> void:
	if not has_node("Options") and event.is_action_pressed("ui_cancel"):
		self.queue_free()

func _exit_tree() -> void:
	get_tree().paused = false


func _on_continuar_pressed() -> void:
	self.queue_free()


func _on_opcoes_pressed() -> void:
	var opt = options.instantiate()
	add_child(opt)
	get_tree().paused = true


func _on_menu_pressed() -> void:
	Global.Player1 = null
	Global.Player2 = null
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")
