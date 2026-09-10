extends Node2D

@onready var P1Spawn: Marker2D = $Stage/P1Spawn
@onready var P2Spawn: Marker2D = $Stage/P2Spawn

var vel = 200

#Isso aq é só pra tornar utilizavel o codigo o valor do path sera alterado via script posteriormente
var player_1 = "res://Entities/Alim/AlimStudent.tscn"
var player_2 = "res://Entities/Agro/AgroStudent.tscn"

func spawnPlayers():
	var p1 = load(player_1).instantiate()
	var p2 = load(player_2).instantiate()
	
	p1.player_id = 1
	p1.global_position = P1Spawn.global_position
	add_child(p1)
	
	p2.player_id = 2
	p2.global_position = P2Spawn.global_position
	p2.get_node("AnimatedSprite2D").flip_h = true
	add_child(p2)
	
func _ready():
	spawnPlayers()
	
