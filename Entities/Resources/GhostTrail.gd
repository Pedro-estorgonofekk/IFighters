extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func SetupSprite(original_sprite: AnimatedSprite2D):
	sprite.sprite_frames = original_sprite.sprite_frames
	sprite.animation = original_sprite.animation
	sprite.frame = original_sprite.frame
	sprite.flip_h = original_sprite.flip_h
	sprite.scale = original_sprite.scale
	sprite.modulate.a = 0.5
	sprite.z_index = 1

	self.position += Vector2(randi_range(-5, 5), randi_range(-10,-15))
	
	sprite.pause()
	FadeOut()
	
func FadeOut():
	var tween = create_tween()
	
	tween.tween_property(self, "modulate", Color(10.0, 10.0, 10.0, 1.0), 0.1)
	tween.tween_property(self, "modulate:a", 0.0, 0.1)
	tween.tween_callback(self.queue_free)
