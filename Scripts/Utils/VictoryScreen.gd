extends Control

@onready var confetti = $Confetti
@onready var lbl_player1 = $Player1
@onready var lbl_player2 = $Player2

var winner: int
var character_p1: CharacterBody2D
var character_p2: CharacterBody2D

func _ready() -> void:
	var vencedor = character_p1 if winner == 1 else character_p2
	RemoveControls()
	
	if is_instance_valid(vencedor):
		vencedor.win = true
		
	confetti.play("default")
	
	if winner == 1:
		character_p2.anim.play("defeat")
		PlayerJump(character_p1)
	elif winner == 2:
		character_p1.anim.play("defeat")
		PlayerJump(character_p2)
	
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
