extends Node2D

func _ready() -> void:
	self.emitting = true
	await get_tree().create_timer(self.lifetime).timeout
	queue_free()
