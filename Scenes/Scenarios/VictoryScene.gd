extends Node2D

@export var victory_scene: PackedScene

var round_over: bool = false

func _process(delta: float) -> void:
	if round_over:
		return
		
	if Global.points_p1 >=2 or Global.points_p2 >= 2:
		TriggerVictoryScene()
		
func TriggerVictoryScene() -> void:
	victory_scene.player1 = 1
