extends Area2D

@export var speed := 400
@export var spin := 50
@export var damage: int
@export var direction := 1
@export var spinnable: bool


func _process(delta: float) -> void:
	self.global_position.x += (delta * speed) * direction
	if spinnable: self.rotation += spin
	
	if global_position.x > 1100 or global_position.x < -150:
		self.queue_free()
