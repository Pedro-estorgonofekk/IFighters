extends Node2D

@export var life_ticks := 5
@export var life_regen := 10

@onready var caster: CharacterBody2D
@onready var health = caster.get_node("Health")

func _ready() -> void:
	SunMovement(true)
	Heal(life_regen)

func SunMovement(spawn):
	var tween = create_tween()
	
	if spawn:
		tween.tween_property(self, "global_position:y", 95, 0.5)
		get_tree().call_group("Camera", "ApplyShake", 1)
		get_tree().call_group("Vignette", "PlayVignette", spawn, Color.GREEN_YELLOW)
		
	else:
		tween.tween_property(self, "global_position:y", -95, 0.5)
		
		get_tree().call_group("Camera", "ApplyShake", 1)
		get_tree().call_group("Vignette", "PlayVignette", spawn, Color.GREEN_YELLOW)
		
		await tween.finished
		
		self.queue_free()

func Heal(amount: int):
	for i in range(life_ticks):
		health.Heal(amount)
		get_tree().call_group("Camera", "ApplyShake", 0.5)
		await get_tree().create_timer(1.5).timeout
		
	SunMovement(false)
