extends ColorRect

var personagens = ["res://Entities/Agro/AgroStudent.tscn",
"res://Entities/Info/InfoStudent.tscn",
"res://Entities/Adm/AdmStudent.tscn",
"res://Entities/Meio/MeioStudent.tscn",
"res://Entities/Geo/GeoStudent.tscn",
"res://Entities/Alim/AlimStudent.tscn"
]


func _ready() -> void:
	$RandomButton.grab_focus()




func _process(delta: float) -> void:
	if Global.Player1 != null and Global.Player2 != null:
		get_tree().change_scene_to_file("res://Scenes/Scenarios/FightScene.tscn")

func _on_agro_button_pressed() -> void:
	if Global.Player1 != null:
		Global.Player2 = "res://Entities/Agro/AgroStudent.tscn"
	else:
		Global.Player1 = "res://Entities/Agro/AgroStudent.tscn"

func _on_info_button_pressed() -> void:
	if Global.Player1 != null:
		Global.Player2 = "res://Entities/Info/InfoStudent.tscn"
	else:
		Global.Player1 = "res://Entities/Info/InfoStudent.tscn"
	
func _on_alim_button_pressed() -> void:
	if Global.Player1 != null:
		Global.Player2 = "res://Entities/Alim/AlimStudent.tscn"
	else:
		Global.Player1 = "res://Entities/Alim/AlimStudent.tscn"
func _on_meio_button_pressed() -> void:
	if Global.Player1 != null:
		Global.Player2 = "res://Entities/Meio/MeioStudent.tscn"
	else:
		Global.Player1 = "res://Entities/Meio/MeioStudent.tscn"
	
func _on_geo_button_pressed() -> void:
	if Global.Player1 != null:
		Global.Player2 = "res://Entities/Geo/GeoStudent.tscn"
	else:
		Global.Player1 = "res://Entities/Geo/GeoStudent.tscn"
	
func _on_adm_button_pressed() -> void:
	if Global.Player1 != null:
		Global.Player2 = "res://Entities/Adm/AdmStudent.tscn"
	else:
		Global.Player1 = "res://Entities/Adm/AdmStudent.tscn"

func _on_random_button_pressed() -> void:
	if Global.Player1 != null:
		Global.Player2 = personagens.pick_random()
	else:
		Global.Player1 = personagens.pick_random()
	
