extends Camera2D

@export var fade: float = 15.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func _ready() -> void:
	add_to_group("Camera")

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, fade * delta)
		offset = Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
	
	else:
		offset = Vector2.ZERO

func ApplyShake(amount: float):
	shake_strength = max(shake_strength, amount)
