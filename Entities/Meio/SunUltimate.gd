extends Node2D

@export var life_ticks = 10
@export var life_regen := 10

@onready var caster: CharacterBody2D
@onready var health = caster.get_node("Health")


func _ready() -> void:
	$AnimatedSprite2D.global_position = Vector2(480, 240)
	Heal(life_regen)
	pass


func Heal(amount: int):
	for i in range(life_ticks):
		health.Heal(amount)
		await get_tree().create_timer(1.5).timeout
	
	self.queue_free()
