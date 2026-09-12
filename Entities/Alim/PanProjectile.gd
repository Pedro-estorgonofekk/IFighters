extends Area2D

var speed := 500
var spin := 50
var damage: int
var direction := 1

func _process(delta: float) -> void:
	self.global_position.x += (delta * speed) * direction
	self.rotation += spin
	
	print(global_position)
	
	if global_position.x > 960 or global_position.x < 0:
		self.queue_free() 
