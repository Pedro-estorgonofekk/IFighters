class_name Hurtbox
extends Area2D

signal receivedDmg(amount: int)

@export var health: Health 

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Hitbox and health:
		health.takeDmg(area.damage)
		receivedDmg.emit(area.damage)
