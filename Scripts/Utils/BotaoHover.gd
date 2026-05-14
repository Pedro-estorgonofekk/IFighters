extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered():
	sobre()



func _on_mouse_exited():
	saiu()
	
func sobre():
	modulate = Color(0.7,0.7,0.7,0.7)
	
func saiu():
	modulate = Color(1.0,1.0,1.0,1.0)

	
