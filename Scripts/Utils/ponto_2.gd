extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PontoFundo1.visible = false
	$PontoFundo2.visible = false
	att_points()

func att_points():
	if Global.points_p2 == 1:
		$PontoFundo1.visible = true
	if Global.points_p2 == 2:
		$PontoFundo2.visible = true
		$PontoFundo1.visible = true
		get_tree().paused = true
	
		
		
		
