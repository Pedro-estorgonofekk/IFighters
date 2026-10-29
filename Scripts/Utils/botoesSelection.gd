extends TextureButton

var MolduraP1 = preload("res://Assets/Sprites/MolduraP1.png")
var MolduraP2 = preload("res://Assets/Sprites/MolduraP2.png")
var MolduraRandom = preload("res://Assets/Sprites/FundoRandom.png")
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var botao = get_viewport().gui_get_focus_owner()
	if botao.name != "RandomButton":
		if Global.Player1 == null:
			texture_focused = MolduraP1
		else: 
			texture_focused = MolduraP2
	else:
		texture_focused = MolduraRandom
