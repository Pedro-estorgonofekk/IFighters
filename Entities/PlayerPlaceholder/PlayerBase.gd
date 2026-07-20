extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const DASH_SPEED = 900.0
const DASH_DURATION = 0.15
const DASH_COOLDOWN = 0.4

var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = 0.0

func _ready() -> void:
	anim.play("idle")

func _physics_process(delta: float) -> void:
	if dash_timer > 0:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta

	var direction := Input.get_axis("EsquerdaP1", "DireitaP1")

	if is_dashing:
		velocity.x = dash_direction * DASH_SPEED
		# anim.play("dash")
	else:
		if Input.is_action_pressed("AgachaP1") and is_on_floor():
			velocity.x = 0
			anim.play("crouch")
		elif direction != 0:
			velocity.x = direction * SPEED
			anim.stop()
			anim.flip_h = (direction < 0)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			anim.play("idle")

		if Input.is_action_just_pressed("PulaP1") and is_on_floor() and not Input.is_action_pressed("AgachaP1"):
			velocity.y = JUMP_VELOCITY

		if Input.is_action_just_pressed("DashP1") and dash_cooldown_timer <= 0 and direction != 0:
			is_dashing = true
			dash_timer = DASH_DURATION
			dash_cooldown_timer = DASH_COOLDOWN
			dash_direction = direction
			velocity.y = 0

	move_and_slide()
