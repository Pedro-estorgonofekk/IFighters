extends Control

@onready var explosion = $Explosion

var player1: CharacterBody2D
var player2: CharacterBody2D

func _ready() -> void:
	print(player1)
