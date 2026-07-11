extends TextureRect

func _on_story_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scenarios/FightScene.tscn")


func _on_opcoes_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Config.tscn")
