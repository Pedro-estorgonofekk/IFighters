extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox := $Hitbox
@onready var hurtbox := $Hurtbox
@export var player_id: int

const speed = 300.0
const jump_velocity = -650.0

const dash_speed = 900.0
const dash_duration = 0.15
const dash_cooldown = 0.4

var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = 0.0

var action_right: String
var action_left: String
var action_jump: String
var action_crouch: String
var action_dash: String


func setupPlayer():
	if player_id == 1:
		action_right = "DireitaP1"
		action_left = "EsquerdaP1"
		action_jump = "PulaP1"
		action_crouch = "AgachaP1"
		action_dash = "DashP1"

		hitbox.collision_layer = 1
		hitbox.collision_mask = 8
		hurtbox.collision_layer = 2
		hurtbox.collision_mask = 4

	if player_id == 2:
		action_right = "DireitaP2"
		action_left = "EsquerdaP2"
		action_jump = "PulaP2"
		action_crouch = "AgachaP2"
		action_dash = "DashP2"

		hitbox.collision_layer = 4
		hitbox.collision_mask = 2
		hurtbox.collision_layer = 8
		hurtbox.collision_mask = 1

func _ready() -> void:
	setupPlayer()
	anim.play("idle")

func _physics_process(delta: float) -> void:
	if dash_timer > 0:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta * 1.3

	var direction := Input.get_axis(action_left, action_right)

	if is_dashing:
		velocity.x = dash_direction * dash_speed
		# anim.play("dash")
	else:
		if Input.is_action_pressed(action_crouch) and is_on_floor():
			velocity.x = 0
			# anim.play("crouch")
			
		elif direction != 0:
			velocity.x = direction * speed
			anim.stop()
			anim.flip_h = (direction < 0)
		
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			anim.play("idle")

		if Input.is_action_just_pressed(action_jump) and is_on_floor() and not Input.is_action_pressed(action_crouch):
			velocity.y = jump_velocity

		if Input.is_action_just_pressed(action_dash) and dash_cooldown_timer <= 0 and direction != 0:
			is_dashing = true
			dash_timer = dash_duration
			dash_cooldown_timer = dash_cooldown
			dash_direction = direction
			velocity.y = 0
			
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			
			if collider.is_in_group("Player") and collision.get_normal().y < 0:
				var direcao_escorrego = 15.0 if global_position.x > collider.global_position.x else -15.0
				velocity.y = 0
				move_local_x(direcao_escorrego)
				print("bucecha")

	move_and_slide()
