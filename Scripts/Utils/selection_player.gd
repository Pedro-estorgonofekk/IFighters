extends ColorRect

var personagens = ["res://Entities/Agro/AgroStudent.tscn",
"res://Entities/Info/InfoStudent.tscn",
"res://Entities/Adm/AdmStudent.tscn",
"res://Entities/Meio/MeioStudent.tscn",
"res://Entities/Geo/GeoStudent.tscn",
"res://Entities/Alim/AlimStudent.tscn"
]
#Sprites
var agro = preload("res://Entities/Agro/Sprites/paradinho agro.png")
var info = preload("res://Entities/Info/Sprites/paradinho info.png")
var alim = preload("res://Entities/Alim/Sprites/paradinho.png")
var geo = preload("res://Entities/Geo/Sprites/paradinho geo.png")
var adm = preload("res://Entities/Adm/Sprites/parado adm.png")
var meio = preload("res://Entities/Meio/Sprites/parada meio.png")
var random = preload("res://Assets/Sprites/RandomSprite.png")
func _ready() -> void:
	$RandomButton.grab_focus()



func _process(delta: float) -> void:
	if Global.Player2 != null:
		get_viewport().gui_release_focus()
	if Global.Player1 != null and Global.Player2 != null and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/Scenarios/FightScene.tscn")
	if Input.is_action_just_pressed("Voltar"):
		if Global.Player2 == null:
			Global.Player1 = null
			$Personagem2.texture = null
			$Nome2.text = ""
		else:
			Global.Player2 = null
			$RandomButton.grab_focus()
		if Global.Player1 == null and Global.Player2 == null:
			get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")



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
		if "Info" in Global.Player2:
			$Personagem2.texture = info
			$Nome2.text = "Informatica"
		elif "Alim" in Global.Player2:
			$Personagem2.texture = alim
			$Nome2.text = "Alimentos"
		elif "Geo" in Global.Player2:
			$Personagem2.texture = geo
			$Nome2.text = "Geo"
		elif "Agro" in Global.Player2:
			$Personagem2.texture = agro
			$Nome2.text = "Agropecuaria"
		elif "Meio" in Global.Player2:
			$Personagem2.texture = meio
			$Nome2.text = "Meio Ambiente"
		elif "Adm" in Global.Player2:
			$Personagem2.texture = adm
			$Nome2.text = "Adm"
	else:
		Global.Player1 = personagens.pick_random()
		if "Info" in Global.Player1:
			$Personagem1.texture = info
			$Nome1.text = "Informatica"
		elif "Alim" in Global.Player1:
			$Personagem1.texture = alim
			$Nome1.text = "Alimentos"
		elif "Geo" in Global.Player1:
			$Personagem1.texture = geo
			$Nome1.text = "Geo"
		elif "Agro" in Global.Player1:
			$Personagem1.texture = agro
			$Nome1.text = "Agropecuaria"
		elif "Meio" in Global.Player1:
			$Personagem1.texture = meio
			$Nome1.text = "Meio Ambiente"
		elif "Adm" in Global.Player1:
			$Personagem1.texture = adm
			$Nome1.text = "Adm"
	

#Imagem interativa com selecao
func _on_agro_button_focus_entered() -> void:
	if Global.Player1 == null:
		$Personagem1.texture = agro
		$Nome1.text = "Agropecuaria"
		$Personagem1.scale = Vector2(1, 1)
	else:
		$Personagem2.texture = agro
		$Nome2.text = "Agropecuaria"
		$Personagem2.scale = Vector2(1, 1)

func _on_info_button_focus_entered() -> void:
	if Global.Player1 == null:
		$Personagem1.texture = info
		$Nome1.text = "Informatica"
		$Personagem1.scale = Vector2(1, 1)
	else:
		$Personagem2.texture = info
		$Nome2.text = "Informatica"
		$Personagem2.scale = Vector2(1, 1)

func _on_alim_button_focus_entered() -> void:
	if Global.Player1 == null:
		$Personagem1.texture = alim
		$Nome1.text = "Alimentos"
		$Personagem1.scale = Vector2(1, 1)
	else:
		$Personagem2.texture = alim
		$Nome2.text = "Alimentos"
		$Personagem2.scale = Vector2(1, 1)

func _on_meio_button_focus_entered() -> void:
	if Global.Player1 == null:
		$Personagem1.texture = meio
		$Nome1.text = "Meio Ambiente"
		$Personagem1.scale = Vector2(1, 1)
	else:
		$Personagem2.texture = meio
		$Nome2.text = "Meio Ambiente"
		$Personagem2.scale = Vector2(1, 1)

func _on_geo_button_focus_entered() -> void:
	if Global.Player1 == null:
		$Personagem1.texture = geo
		$Personagem1.scale = Vector2(1, 1)
		$Nome1.text = "Geo"
	else:
		$Personagem2.texture = geo
		$Nome2.text = "Geo"
		$Personagem2.scale = Vector2(1, 1)

func _on_adm_button_focus_entered() -> void:
	if Global.Player1 == null:
		$Personagem1.texture = adm
		$Nome1.text = "Adm"
		$Personagem1.scale = Vector2(1, 1)
	else:
		$Personagem2.texture = adm
		$Nome2.text = "Adm"
		$Personagem2.scale = Vector2(1, 1)

func _on_random_button_focus_entered() -> void:
	if Global.Player1 == null:
		$Personagem1.texture = random
		$Personagem1.scale = Vector2(0.9, 0.9)
		$Nome1.text = "Aleatorio"
	else:
		$Personagem2.texture = random
		$Nome2.text = "Aleatorio"
		$Personagem2.scale = Vector2(0.9, 0.9)
