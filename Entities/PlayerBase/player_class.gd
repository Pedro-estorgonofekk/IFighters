extends Node2D
class_name Player

@export var health = 100
@export var charName : String
@export var hurtbox: Area2D
@export var progressBar: ProgressBar

func _ready() -> void:
	return
	
func DamageTaken(damage):
	health -= damage
