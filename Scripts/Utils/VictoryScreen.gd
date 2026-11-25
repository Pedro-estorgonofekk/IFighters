extends CanvasLayer

@onready var confetti = $Control/Confetti
@onready var lbl_player1: Label = $Control/Player1
@onready var lbl_player2: Label = $Control/Player2

var winner: int
var character_p1: CharacterBody2D
var character_p2: CharacterBody2D

func _ready() -> void:
	lbl_player1.visible = false
	lbl_player2.visible = true
	
	var vencedor = character_p1 if winner == 1 else character_p2
	RemoveControls()
	
	if is_instance_valid(vencedor):
		vencedor.win = true
		
	confetti.play("default")
	
	if winner == 1:
		character_p2.ChangeState(character_p2.State.DEFEAT)
		PlayerJump(character_p1)
		SlideLabel(lbl_player1)
		
	elif winner == 2:
		character_p1.ChangeState(character_p1.State.DEFEAT)
		PlayerJump(character_p2)
		SlideLabel(lbl_player2)
		
	await get_tree().create_timer(5).timeout
	
	get_tree().change_scene_to_file("res://Scenes/UI/SelectionPlayer.tscn")
	
func RemoveControls() -> void:
	if is_instance_valid(character_p1):
		character_p1.control = false
	if is_instance_valid(character_p2):
		character_p2.control = false
		
func PlayerJump(plr):
	plr.velocity.y = plr.JUMP_VELOCITY
	plr.anim.play("jump")
	plr.SquashStretch(Vector2(0.7, 1.3))
	plr.SpawnDust()

func SlideLabel(lbl: Label) -> void:
	lbl.visible = true
	lbl.position.y = -100.0
	
	var tween = create_tween()
	tween.tween_property(lbl, "position:y", 270.0, 0.8)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
