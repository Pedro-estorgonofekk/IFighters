extends Node2D

@onready var P1Spawn: Marker2D = $Stage/P1Spawn
@onready var P2Spawn: Marker2D = $Stage/P2Spawn

@export var HealthBar1: Control
@export var HealthBar2: Control

@onready var stamina_p1: TextureProgressBar = $StaminaBar
@onready var stamina_p2: TextureProgressBar = $StaminaBar2

var vel = 200

# Valor do path que será alterado via script posteriormente
var player_1 = "res://Entities/Meio/MeioStudent.tscn"
var player_2 = "res://Entities/Meio/MeioStudent.tscn"

var p1 = load(player_1).instantiate()
var p2 = load(player_2).instantiate()


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


func _ready():
	SpawnPlayers()

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
	var p1_health = p1.get_node("Health")
	var p2_health = p2.get_node("Health")
	
	p1_health.healthCabo.connect(_on_health_depleted)
	p2_health.healthCabo.connect(_on_health_depleted)
	
	if HealthBar1:
		HealthBar1.update_bar(p1_health.playerHealth, p1_health.maxHealth)
		p1_health.healthMudou.connect(_on_p1_health_changed)
		
	if HealthBar2:
		HealthBar2.update_bar(p2_health.playerHealth, p2_health.maxHealth)
		p2_health.healthMudou.connect(_on_p2_health_changed)


func _on_p1_health_changed(currentHealth):
	if HealthBar1:
		HealthBar1.update_bar(currentHealth, p1.get_node("Health").maxHealth)


func _on_p2_health_changed(currentHealth):
	if HealthBar2:
		HealthBar2.update_bar(currentHealth, p2.get_node("Health").maxHealth)


func _on_health_depleted() -> void:
	print("Fui chamado")
	await get_tree().create_timer(2).timeout
	
	if p1.get_node("Health").playerHealth > p2.get_node("Health").playerHealth:
		print("Player 1 Ganhou")
	elif p1.get_node("Health").playerHealth < p2.get_node("Health").playerHealth:
		print("Player 2 Ganhou")
	else:
		print("Empate")
		
	get_tree().reload_current_scene()
