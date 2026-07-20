class_name Hurtbox
extends Area2D

signal receivedDmg

@export var health: Health 

func _ready() -> void:
	connect("area_entered", on_area_entered)

func on_area_entered(hitbox: Hitbox) -> void:
	if hitbox:
		health.playerHealth -= hitbox.damage
		receivedDmg.emit(hitbox.damage)
