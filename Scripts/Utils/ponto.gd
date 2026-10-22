extends CanvasLayer

func _ready() -> void:
	$PontoFundo1.visible = false
	$PontoFundo2.visible = false
	att_points()

var exit_screen_scene = preload("res://Scenes/UI/ExitScreen.tscn")

func att_points():
	if Global.points_p1 == 1:
		$PontoFundo1.visible = true
	if Global.points_p1 == 2:
		$PontoFundo1.visible = true
		$PontoFundo2.visible = true
		get_tree().paused = true
