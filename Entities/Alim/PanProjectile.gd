extends Area2D

var speed = 500
var spin = 50

func _process(delta: float) -> void:
	self.global_position.x += delta * speed
	self.rotation += spin
	
	if global_position.x > 960:
		self.queue_free() 
