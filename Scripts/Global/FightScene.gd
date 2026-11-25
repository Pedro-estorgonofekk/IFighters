
extends Node2D

@onready var P1Spawn: Marker2D = $Stage/P1Spawn
@onready var P2Spawn: Marker2D = $Stage/P2Spawn

@export var health_bar1: Control
@export var health_bar2: Control

@onready var stamina_p1: TextureProgressBar = $StaminaBar
@onready var stamina_p2: TextureProgressBar = $StaminaBar2

signal round_ended

var player_1 = Global.Player1
var player_2 = Global.Player2

var p1 = load(player_1).instantiate()
var p2 = load(player_2).instantiate()

var round_over: bool = false

func SpawnPlayers():
	if player_1 == player_2:
		p2.modulate = Color(0.6, 0.6, 1)
		
	p1.player_id = 1
	p1.global_position = P1Spawn.global_position
	add_child(p1)
	
	p2.player_id = 2
	p2.global_position = P2Spawn.global_position
	p2.get_node("AnimatedSprite2D").flip_h = true
		
	add_child(p2)

func _process(delta: float) -> void:
	$CanvasLayer/TimerLabel.text = str(int($Timer.time_left))
	
func _ready():
	$P1Icon/TextureRect.texture = pegar_sprite_personagem(Global.Player1)
	$P2Icon/TextureRect.texture = pegar_sprite_personagem(Global.Player2)
	SpawnPlayers()
	round_ended.connect($Ponto.att_points)
	round_ended.connect($Ponto2.att_points)
	
	# Stamina dos players
	if p1 and p1.stamina and stamina_p1:
		stamina_p1.max_value = p1.stamina.max_stamina
		stamina_p1.value = p1.stamina.current_stamina
		p1.stamina.StaminaChanged.connect(func(current: float, _max: float):
			stamina_p1.value = current
		)

	if p2 and p2.stamina and stamina_p2:
		stamina_p2.max_value = p2.stamina.max_stamina
		stamina_p2.value = p2.stamina.current_stamina
		p2.stamina.StaminaChanged.connect(func(current: float, _max: float):
			stamina_p2.value = current
		)
		
	# Vida dos players
	var p1_health = p1.get_node("Health")
	var p2_health = p2.get_node("Health")
	
	p1_health.healthCabo.connect(_on_health_depleted)
	p2_health.healthCabo.connect(_on_health_depleted)
	
	if health_bar1:
		health_bar1.update_bar(p1_health.playerHealth, p1_health.maxHealth)
		p1_health.healthMudou.connect(_on_p1_health_changed)
		
	if health_bar2:
		health_bar2.update_bar(p2_health.playerHealth, p2_health.maxHealth)
		p2_health.healthMudou.connect(_on_p2_health_changed)


func _on_p1_health_changed(currentHealth):
	if health_bar1:
		health_bar1.update_bar(currentHealth, p1.get_node("Health").maxHealth)


func _on_p2_health_changed(currentHealth):
	if health_bar2:
		health_bar2.update_bar(currentHealth, p2.get_node("Health").maxHealth)


func _on_health_depleted() -> void:
	if round_over:
		return
	
	round_over = true
	
	print("Fui chamado")
	await get_tree().create_timer(1).timeout
	
	if get_tree() == null:
		return
	
	if p1.get_node("Health").playerHealth > p2.get_node("Health").playerHealth:
		Global.points_p1 += 1
		
	elif p1.get_node("Health").playerHealth < p2.get_node("Health").playerHealth:
		Global.points_p2 += 1
		
	else:
		print("Empate")
	
	round_ended.emit()
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()


func _on_timer_timeout() -> void:
	if p1.get_node("Health").playerHealth > p2.get_node("Health").playerHealth:
		Global.points_p1 += 1
		
	elif p1.get_node("Health").playerHealth < p2.get_node("Health").playerHealth:
		Global.points_p2 += 1
	get_tree().reload_current_scene()
	
func pegar_sprite_personagem(personagem) -> Texture2D:
	# Garante que funciona tanto se Global.player1/player2 for String quanto PackedScene
	var caminho: String = personagem if personagem is String else personagem.resource_path

	if caminho.ends_with("InfoStudent.tscn"):
		return load("res://Entities/Info/Sprites/paradinho info.png")
	elif caminho.ends_with("AdmStudent.tscn"):
		return load("res://Entities/Adm/Sprites/parado adm.png")
	elif caminho.ends_with("AgroStudent.tscn"):
		return load("res://Entities/Agro/Sprites/paradinho agro.png")
	elif caminho.ends_with("AlimStudent.tscn"):
		return load("res://Entities/Alim/Sprites/paradinho.png")
	elif caminho.ends_with("GeoStudent.tscn"):
		return load("res://Entities/Geo/Sprites/paradinho geo.png")
	elif caminho.ends_with("MeioStudent.tscn"):
		return load("res://Entities/Meio/Sprites/parada meio.png")

	return null
	
