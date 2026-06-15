extends CharacterBody2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
func _ready() -> void:
	anim.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("PulaP1") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("EsquerdaP1", "DireitaP1")
	if direction:
		velocity.x = direction * SPEED
		anim.stop()
		if direction > 0:
			anim.flip_h = false
		elif direction< 0:
			anim.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")
		
	if Input.is_action_just_pressed("DashP1") and Input.is_action_pressed("DireitaP1")and !Input.is_action_pressed("EsquerdaP1"):
		velocity.x = 5000
	if Input.is_action_just_pressed("DashP1") and Input.is_action_pressed("EsquerdaP1") and !Input.is_action_pressed("DireitaP1"):
		velocity.x = -5000
	if Input.is_action_pressed("AgachaP1"):
		velocity.x = direction * 0
		
	move_and_slide()
