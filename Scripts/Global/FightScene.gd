extends Node2D

@onready var P1Spawn: Marker2D = $Stage/P1Spawn
@onready var P2Spawn: Marker2D = $Stage/P2Spawn

var vel = 200

#Isso aq é só pra tornar utilizavel o codigo o valor do path sera alterado via script posteriormente
var player_1 = "res://Entities/Adm/AdmStudent.tscn"
var player_2 = "res://Entities/Info/InfoStudent.tscn"

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
	p1.get_node("Health").healthDepleted.connect(_on_health_depleted)
	p2.get_node("Health").healthDepleted.connect(_on_health_depleted)
	
func _on_health_depleted() -> void:
	print("Fui chamado")
	await get_tree().create_timer(2).timeout
	
	if p1.get_node("Health").playerHealth > p2.get_node("Health").playerHealth:
		print("Player 1 Ganhou")
	elif p1.get_node("Health").playerHealth < p2.get_node("Health").playerHealth:
		print("Plyer 2 Ganhou")
	else:
		print("Empate")
		
	get_tree().reload_current_scene()
