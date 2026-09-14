extends Area2D

var speed := 500
var damage: int
var direction := 1

func _process(delta: float) -> void:
	self.global_position.x += (delta * speed) * direction
	
	if global_position.x > 960 or global_position.x < 0:
		self.queue_free() 
