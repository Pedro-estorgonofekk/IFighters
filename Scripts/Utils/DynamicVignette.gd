extends ColorRect

func _ready() -> void:
	material.set_shader_parameter("alpha", 0.0)

func PlayVignette(spawn, ult_color: Color) -> void:
	material.set_shader_parameter("vignette_color", ult_color)
	
	var tween = create_tween()
	if spawn:
		tween.tween_property(material, "shader_parameter/alpha", 0.15, 0.2)
	else:
		tween.tween_property(material, "shader_parameter/alpha", 0.0, 0.5)
