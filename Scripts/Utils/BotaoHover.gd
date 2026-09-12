extends TextureButton

func _on_mouse_entered() -> void:
	sobre()
func _on_mouse_exited() -> void:
	saiu()
func sobre() -> void:
	modulate = Color(0.7,0.7,0.7,0.7)
func saiu() -> void:
	modulate = Color(1.0,1.0,1.0,1.0)

	
