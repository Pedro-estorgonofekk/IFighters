extends Area2D

@export var speed := 600
@export var spin := 50
@export var damage: int
@export var direction := 1
@export var spinnable: bool

func _process(delta: float) -> void:
	self.global_position.x += (delta * speed) * direction
	if spinnable: self.rotation += spin
	
	if global_position.x > 960 or global_position.x < 0:
		self.queue_free() 

func _on_area_entered(area: Area2D) -> void:
	print(area)
	if area.name == "Hurtbox":
		var target = area.get_parent()
		var health_node = target.get_node_or_null("Health")
		
		if health_node:
			health_node.TakeDmg(damage)
			get_node("CollisionShape2D").set_deferred("disabled", true)
