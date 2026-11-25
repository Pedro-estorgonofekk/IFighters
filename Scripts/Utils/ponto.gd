extends CanvasLayer

signal p1_win

func _ready() -> void:
	$PontoFundo1.visible = false
	$PontoFundo2.visible = false
	att_points()

func att_points():
	if Global.points_p1 == 1:
		$PontoFundo1.visible = true
	if Global.points_p1 == 2:
		$PontoFundo1.visible = true
		$PontoFundo2.visible = true
		p1_win.emit()
