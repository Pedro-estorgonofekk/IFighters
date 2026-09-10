extends CharacterBody2D

# 1. Definição dos Estados
enum State { IDLE, MOVE, CROUCH, JUMP, FALL, DASH }
var current_state: State = State.IDLE

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox := $Hitbox
@onready var hurtbox := $Hurtbox

#Hitboxes
@onready var cs_idle_hit: CollisionShape2D = $Hitbox/CSIdleHit
@onready var cs_punch_hit: CollisionShape2D = $Hitbox/CSPunchHit
@onready var cs_bullet_hit: CollisionShape2D = $Hitbox/CSBulletHit
@onready var cs_crouch_hit: CollisionShape2D = $Hitbox/CSCrouchHit
@onready var cs_ult_hit: CollisionShape2D = $Hitbox/CSUltHit

#Hurtboxes
@onready var cs_idle_hurt: CollisionShape2D = $Hurtbox/CSIdleHurt
@onready var cs_punch_hurt: CollisionShape2D = $Hurtbox/CSPunchHurt
@onready var cs_bullet_hurt: CollisionShape2D = $Hurtbox/CSBulletHurt
@onready var cs_crouch_hurt: CollisionShape2D = $Hurtbox/CSCrouchHurt
@onready var cs_ult_hurt: CollisionShape2D = $Hurtbox/CSUltHurt


@export var player_id: int

# Constantes de Física
const SPEED = 300.0
const JUMP_VELOCITY = -700.0
const DASH_SPEED = 900.0
const DASH_DURATION = 0.15
const DASH_COOLDOWN = 0.4

# Variáveis do Dash
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = 0.0

# Controles Dinâmicos
var action_right: String
var action_left: String
var action_jump: String
var action_crouch: String
var action_dash: String

# Variaveis Aux. Direção Player
var opponent : CharacterBody2D 

func setup_player() -> void:
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

	elif player_id == 2:
		action_right = "DireitaP2"
		action_left = "EsquerdaP2"
		action_jump = "PulaP2"
		action_crouch = "AgachaP2"
		action_dash = "DashP2"

		hitbox.collision_layer = 4
		hitbox.collision_mask = 2
		hurtbox.collision_layer = 8
		hurtbox.collision_mask = 1

func find_opponent():
	var players = get_tree().get_nodes_in_group("Player")
	
	for i in players:
		if i != self:
			opponent = i
			break

func face_direction():
	if opponent == null: return
	
	if opponent.global_position.x < global_position.x:
		anim.flip_h = true
		
	else:
		anim.flip_h = false

func _ready() -> void:
	setup_player()
	disable_collision()
	change_state(State.IDLE)
	call_deferred("find_opponent")

func _physics_process(delta: float) -> void:
	
	face_direction()
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	# Aplica gravidade fora do chão (exceto durante o dash)
	if not is_on_floor() and current_state != State.DASH:
		velocity += get_gravity() * delta * 1.3

	# Executa a lógica do estado atual
	match current_state:
		State.IDLE:
			state_idle()
		State.MOVE:
			state_move()
		State.CROUCH:
			state_crouch()
		State.JUMP:
			state_jump()
		State.FALL:
			state_fall()
		State.DASH:
			state_dash(delta)

	# Lógica para não ficar em cima do oponente (escorregar)
	tratar_colisao_com_oponente()

	move_and_slide()



func disable_collision():
	#Hitbox
	cs_idle_hit.disabled = true
	cs_punch_hit.disabled = true
	cs_bullet_hit.disabled = true
	cs_crouch_hit.disabled = true
	cs_ult_hit.disabled = true
	
	#hurtbox
	cs_idle_hurt.disabled = true
	cs_punch_hurt.disabled = true
	cs_bullet_hurt.disabled = true
	cs_crouch_hurt.disabled = true
	cs_ult_hurt.disabled = true
	
	
	
	
	
	
# --- GERENCIADOR DE TRANSIÇÃO DE ESTADOS ---

func change_state(new_state: State) -> void:
	current_state = new_state

	match current_state:
		State.IDLE:
			anim.play("idle")
		State.MOVE:
			anim.play("walk")
		State.CROUCH:
			velocity.x = 0
			anim.play("crouch")
		State.JUMP:
			velocity.y = JUMP_VELOCITY
			anim.play("jump")
		State.FALL:
			pass # anim.play("fall")
		State.DASH:
			dash_timer = DASH_DURATION
			dash_cooldown_timer = DASH_COOLDOWN
			velocity.y = 0
			anim.play("dash")


# --- COMPORTAMENTO DOS ESTADOS ---

func state_idle() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)
	cs_idle_hit.disabled = false
	cs_idle_hurt.disabled = false

	# Transições
	if tentar_dash():
		return
	if Input.is_action_just_pressed(action_jump) and is_on_floor():
		change_state(State.JUMP)
	elif Input.is_action_pressed(action_crouch) and is_on_floor():
		change_state(State.CROUCH)
	elif Input.get_axis(action_left, action_right) != 0:
		change_state(State.MOVE)
	elif not is_on_floor():
		change_state(State.FALL)


func state_move() -> void:
	var direction := Input.get_axis(action_left, action_right)

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		change_state(State.IDLE)
		return

	# Transições
	if tentar_dash():
		return
	if Input.is_action_just_pressed(action_jump) and is_on_floor():
		change_state(State.JUMP)
	elif Input.is_action_pressed(action_crouch) and is_on_floor():
		change_state(State.CROUCH)
	elif not is_on_floor():
		change_state(State.FALL)


func state_crouch() -> void:
	velocity.x = 0

	# Soltou o agachar
	if not Input.is_action_pressed(action_crouch):
		if Input.get_axis(action_left, action_right) != 0:
			change_state(State.MOVE)
		else:
			change_state(State.IDLE)


func state_jump() -> void:
	var direction := Input.get_axis(action_left, action_right)
	velocity.x = direction * SPEED

	# Quando começa a descer
	if velocity.y > 0:
		change_state(State.FALL)


func state_fall() -> void:
	var direction := Input.get_axis(action_left, action_right)
	velocity.x = direction * SPEED

	# Aterrissou no chão
	if is_on_floor():
		if direction != 0:
			change_state(State.MOVE)
		else:
			change_state(State.IDLE)


func state_dash(delta: float) -> void:
	velocity.x = dash_direction * DASH_SPEED
	dash_timer -= delta

	if dash_timer <= 0:
		if is_on_floor():
			change_state(State.IDLE)
		else:
			change_state(State.FALL)


# --- FUNÇÕES AUXILIARES ---

func tentar_dash() -> bool:
	var direction := Input.get_axis(action_left, action_right)
	if Input.is_action_just_pressed(action_dash) and dash_cooldown_timer <= 0 and direction != 0:
		dash_direction = direction
		change_state(State.DASH)
		return true
	return false


func tratar_colisao_com_oponente() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider and collider.is_in_group("Player") and collision.get_normal().y < 0:
			var slip_direction = 8.0 if global_position.x > collider.global_position.x else -8.0
			velocity.y = 0
			move_local_x(slip_direction)
