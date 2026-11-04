extends TextureButton

var MolduraP1 = preload("res://Assets/Sprites/MolduraP1.png")
var MolduraP2 = preload("res://Assets/Sprites/MolduraP2.png")
var MolduraRandom = preload("res://Assets/Sprites/FundoRandom.png")
var MolduraRandomP2 = preload("res://Assets/Sprites/FundoRandomP2.png")


func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var botao = get_viewport().gui_get_focus_owner()
	if botao != null and botao.name == "RandomButton" and Global.Player1 == null:
		texture_focused = MolduraRandom
	else:
		if botao != null and botao.name == "RandomButton":
			texture_focused = MolduraRandomP2
		else:
			if Global.Player1 == null:
				texture_focused = MolduraP1
			else: 
				texture_focused = MolduraP2
		
