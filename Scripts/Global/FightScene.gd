extends Node2D

@onready var player: Area2D = $Player
@onready var P1Spawn: Marker2D = $Stage/P1Spawn

var vel = 200

func _ready():
	player.global_position = P1Spawn.global_position
