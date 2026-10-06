extends Node2D

@export var life_regen = 10
@export var amount := 10

@onready var caster: CharacterBody2D
@onready var health = caster.get_node("Health")


func _ready() -> void:
	$AnimatedSprite2D.global_position = Vector2(480, 240)
	Heal(life_regen)
	pass

func _process(delta: float) -> void:
	print(health.playerHealth)

func Heal(amount: int):
	print(health.playerHealth)
	
	for i in range(10):
		health.Heal(amount)
		await get_tree().create_timer(1).timeout
