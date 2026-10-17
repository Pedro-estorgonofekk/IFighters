extends Hitbox

@export var speed := 400
@export var spin := 50
@export var direction := 1
@export var spinnable: bool
@export var ult_color: Color

func _ready() -> void:
	get_tree().call_group("Vignette", "PlayVignette", true, ult_color)

func _process(delta: float) -> void:
	self.global_position.x += (delta * speed) * direction
	if spinnable: self.rotation += spin
	
	get_tree().call_group("Camera", "ApplyShake", 1.5)
	
	if global_position.x > 1600 or global_position.x < -650:
		self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Hurtbox":
		var target = area.get_parent()
		var health_node = target.get_node_or_null("Health")
		
		if health_node:
			get_node("CollisionShape2D").set_deferred("disabled", true)
