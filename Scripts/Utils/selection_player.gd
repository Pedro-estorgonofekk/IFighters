extends ColorRect

var personagens = {
	"Adm": {
		"Cena": "res://Entities/Adm/AdmStudent.tscn",
		"Sprite": preload("res://Entities/Adm/Sprites/parado adm.png"),
		"Nome": "Administração"
	},
	"Agro": {
		"Cena": "res://Entities/Agro/AgroStudent.tscn",
		"Sprite": preload("res://Entities/Agro/Sprites/paradinho agro.png"),
		"Nome": "Agropecuaria"
	},
	"Alim": {
		"Cena": "res://Entities/Alim/AlimStudent.tscn",
		"Sprite": preload("res://Entities/Alim/Sprites/paradinho.png"),
		"Nome": "Alimentos"
	},
	"Geo": {
		"Cena": "res://Entities/Geo/GeoStudent.tscn",
		"Sprite": preload("res://Entities/Geo/Sprites/paradinho geo.png"),
		"Nome": "Geoprocessamento"
	},
	"Info": {
		"Cena": "res://Entities/Info/InfoStudent.tscn",
		"Sprite": preload("res://Entities/Info/Sprites/paradinho info.png"),
		"Nome": "Informatica"
	},
	"Meio": {
		"Cena": "res://Entities/Meio/MeioStudent.tscn",
		"Sprite": preload("res://Entities/Meio/Sprites/parada meio.png"),
		"Nome": "Meio Ambiente"
	},
	"Random": {
		"Sprite_P1": preload("res://Assets/Sprites/RandomSprite2.png"),
		"Sprite_P2": preload("res://Assets/Sprites/RandomSprite.png"),
		"Nome": "Aleatorio"
	},
}

@onready var personagem_position = [$Personagem1.position.x, $Personagem2.position.x]

func _ready() -> void:
	Global.Player1 = null
	Global.Player2 = null
	
	Global.points_p1 = 0
	Global.points_p2 = 0
	$RandomButton.grab_focus()

func _process(_delta: float) -> void:
	
	if Global.Player2:
		get_viewport().gui_release_focus()
		
	if Global.Player1 and Global.Player2 and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/Scenarios/FightScene.tscn")
		
	if Input.is_action_just_pressed("Voltar"):
		if !Global.Player1 and !Global.Player2:
			get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")
		if Global.Player1 != null and Global.Player2 == null:
			Global.Player1 = null
			$Personagem1.texture = personagens["Random"]["Sprite_P1"]
			$Nome1.text = "Aleatorio"
			Global.Player2 = null
			$Personagem2.texture = null
			$Nome2.text = ""
			$Personagem1.scale = Vector2(0.9,0.9)
			$RandomButton.grab_focus()
		elif Global.Player2 != null:
			Global.Player2 = null
			$Personagem2.texture = null
			$Nome2.text = ""
			$RandomButton.grab_focus()


	


func SelectCharacter(character: String) -> void:
	var personagem = personagens[character]
	UpdatePreview(personagem["Sprite"], personagem["Nome"])
	
	if !Global.Player1:
		Global.Player1 = personagem["Cena"]
	else:
		Global.Player2 = personagem["Cena"]


func UpdatePreview(sprite: Texture2D, nome: String) -> void:
	if !Global.Player1:
		$Personagem1.texture = sprite
		Slide($Personagem1, 0)
		$Nome1.text = nome
		$Personagem1.scale = Vector2(1, 1)
		
	else:
		$Personagem2.texture = sprite
		Slide($Personagem2, 1, -1)
		$Nome2.text = nome
		$Personagem2.scale = Vector2(1, 1)

func SelectRandomCharacter(obj: TextureRect) -> void:
	var valid_keys = personagens.keys().filter(func(k): return k != "Random")
	var sorteado = personagens[valid_keys.pick_random()]
	
	var tween = create_tween()
	
	for personagem in personagens:
		if personagens[personagem].has("Sprite"):
			tween.tween_callback(_SetTexture.bind(obj, personagens[personagem]["Sprite"]))
			tween.tween_interval(0.05)

	tween.tween_callback(func():
		UpdatePreview(sorteado["Sprite"], sorteado["Nome"])
		if !Global.Player1:
			Global.Player1 = sorteado["Cena"]
		else:
			Global.Player2 = sorteado["Cena"]
	)

func _SetTexture(obj: TextureRect, sprite) -> void:
	obj.texture = sprite

func Slide(obj, plr: int, dir := 1) -> void:
	var tween = create_tween()
	obj.position.x = personagem_position[plr]
	obj.modulate.a = 0
	
	tween.tween_property(obj, "modulate:a", 1, 0.15)
	tween.tween_property(obj, "position:x", personagem_position[plr] + 10 * dir, 0.25)

func UpdateFocus(character: String) -> void:
	var personagem = personagens[character]
	UpdatePreview(personagem["Sprite"], personagem["Nome"])

func _on_agro_button_pressed() -> void:
	SelectCharacter("Agro")

func _on_info_button_pressed() -> void:
	SelectCharacter("Info")
	
func _on_alim_button_pressed() -> void:
	SelectCharacter("Alim")
	
func _on_meio_button_pressed() -> void:
	SelectCharacter("Meio")
	
func _on_geo_button_pressed() -> void:
	SelectCharacter("Geo")
	
func _on_adm_button_pressed() -> void:
	SelectCharacter("Adm")

func _on_random_button_pressed() -> void:
	SelectRandomCharacter($Personagem1 if !Global.Player1 else $Personagem2)

#Imagem interativa com selecao
func _on_agro_button_focus_entered() -> void:
	UpdateFocus("Agro")

func _on_info_button_focus_entered() -> void:
	UpdateFocus("Info")

func _on_alim_button_focus_entered() -> void:
	UpdateFocus("Alim")

func _on_meio_button_focus_entered() -> void:
	UpdateFocus("Meio")

func _on_geo_button_focus_entered() -> void:
	UpdateFocus("Geo")

func _on_adm_button_focus_entered() -> void:
	UpdateFocus("Adm")

func _on_random_button_focus_entered() -> void:
	if !Global.Player1:
		$Personagem1.texture = personagens["Random"]["Sprite_P1"]
		$Personagem1.scale = Vector2(0.9, 0.9)
		$Nome1.text = personagens["Random"]["Nome"]
	else:
		$Personagem2.texture = personagens["Random"]["Sprite_P2"]
		$Personagem2.scale = Vector2(0.9, 0.9)
		$Nome2.text = personagens["Random"]["Nome"]
