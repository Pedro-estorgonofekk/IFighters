extends Area2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var vel = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("DireitaP1"):
		move_local_x(delta * vel)
		anim.stop()
	if Input.is_action_pressed("EsquerdaP1"):
		move_local_x(delta * -vel)
		anim.stop()
		
