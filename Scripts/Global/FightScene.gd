extends Node2D

@onready var P1Spawn: Marker2D = $Stage/P1Spawn
@onready var P2Spawn: Marker2D = $Stage/P2Spawn

@export var health_bar1: Control
@export var health_bar2: Control
@export var victory_scene: PackedScene

@onready var stamina_p1: TextureProgressBar = $StaminaBar
@onready var stamina_p2: TextureProgressBar = $StaminaBar2

@onready var curtain: AnimatedSprite2D = $Curtain

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


func _ready():
	#curtain.play("default")
	await curtain.animation_finished
	
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

	if round_over:
		return

	Engine.time_scale = 0.0
	await get_tree().create_timer(0.08, true, false, true).timeout

	if round_over:
		Engine.time_scale = 0.5
	else:
		Engine.time_scale = 1.0


func _on_p2_health_changed(currentHealth):
	if health_bar2:
		health_bar2.update_bar(currentHealth, p2.get_node("Health").maxHealth)
		
	if round_over:
		return

	Engine.time_scale = 0.0
	await get_tree().create_timer(0.08, true, false, true).timeout

	if round_over:
		Engine.time_scale = 0.5
	else:
		Engine.time_scale = 1.0


func _on_health_depleted() -> void:
	var hp1 = p1.get_node("Health").playerHealth
	var hp2 = p2.get_node("Health").playerHealth
	
	if round_over:
		return
	round_over = true
	
	if get_tree() == null:
		return
	
	if hp1 > hp2:
		Global.points_p1 += 1
	elif hp1 < hp2:
		Global.points_p2 += 1
	else:
		print("Empate")
	
	Engine.time_scale = 0.1
	await get_tree().create_timer(2.0, true, false, true).timeout
	Engine.time_scale = 1
	
	if not is_instance_valid(p1) or not is_instance_valid(p2):
		return
	
	round_ended.emit()
	
	await get_tree().create_timer(0.5, true, false, true).timeout
	
	if not is_inside_tree():
		return
	
	if Global.points_p1 >= 2:
		VictoryScene(1)
	elif Global.points_p2 >= 2:
		VictoryScene(2)
	else:
		get_tree().reload_current_scene()
	

func VictoryScene(win_id: int):
	var scene = victory_scene.instantiate()
	
	scene.winner = win_id
	scene.character_p1 = p1
	scene.character_p2 = p2
	
	add_child(scene)
