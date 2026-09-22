extends CharacterBody2D

# 1. Definição dos Estados
enum State { IDLE, MOVE, CROUCH, JUMP, FALL, DASH, PUNCH, ULT, THROW }
var current_state: State = State.IDLE

# Referências de Nós
@onready var anim := $AnimatedSprite2D
@onready var hitbox := $Hitbox
@onready var hurtbox := $Hurtbox

# Collision Shapes do Corpo
@onready var cs_idle := $CSIdle
@onready var cs_crouch := $CSCrouch

# Hitboxes (Ataques)
@onready var cs_punch_hit := $Hitbox/CSPunchHit

# Hurtboxes (Vulnerabilidade)
@onready var cs_idle_hurt := $Hurtbox/CSIdleHurt
@onready var cs_crouch_hurt := $Hurtbox/CSCrouchHurt

@export var player_id: int

# Constantes de Física
const SPEED = 300.0
const JUMP_VELOCITY = -750.0
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
var action_weak: String
var action_strong: String
var action_ult: String

# Variáveis Auxiliares
var opponent: CharacterBody2D 


func _ready() -> void:
	SetupPlayer()
	DisableCollision()
	
	if anim and not anim.animation_finished.is_connected(_on_animation_finished):
		anim.animation_finished.connect(_on_animation_finished)
		
	if anim and not anim.frame_changed.is_connected(_on_frame_changed):
		anim.frame_changed.connect(_on_frame_changed)
	
	ChangeState(State.IDLE)
	call_deferred("FindOpponent")


func _physics_process(delta: float) -> void:
	if current_state != State.PUNCH:
		FaceDirection()

	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	# Gravidade extra no ar
	if not is_on_floor() and current_state != State.DASH:
		velocity += get_gravity() * delta * 1.3

	# Lógica dos estados
	match current_state:
		State.IDLE:
			StateIdle()
		State.MOVE:
			StateMove()
		State.CROUCH:
			StateCrouch()
		State.JUMP:
			StateJump()
		State.FALL:
			StateFall()
		State.DASH:
			StateDash(delta)
		State.PUNCH:
			StatePunch()
		State.THROW:
			StateThrow()
		State.ULT:
			StateUlt()

	OpponentCollision()
	move_and_slide()


# --- SETUP E CONFIGURAÇÕES DE CONTROLE/COLISÃO ---

func SetupPlayer() -> void:
	if player_id == 1:
		action_right = "DireitaP1"
		action_left = "EsquerdaP1"
		action_jump = "PulaP1"
		action_crouch = "AgachaP1"
		action_dash = "DashP1"
		action_weak = "AtaqueFracoP1"
		action_strong = "AtaqueForteP1"
		action_ult = "UltP1"
		
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
		action_weak = "AtaqueFracoP2"
		action_strong = "AtaqueForteP2"
		action_ult = "UltP2"

		hitbox.collision_layer = 4
		hitbox.collision_mask = 2
		hurtbox.collision_layer = 8
		hurtbox.collision_mask = 1


func FindOpponent() -> void:
	var players = get_tree().get_nodes_in_group("Player")
	for i in players:
		if i != self:
			opponent = i
			break


func FaceDirection() -> void:
	if opponent == null: return
	
	var mirando_esquerda = opponent.global_position.x < global_position.x
	anim.flip_h = mirando_esquerda
	
	# Inverte a orientação horizontal das áreas de colisão
	var dir = -1.0 if mirando_esquerda else 1.0
	hitbox.scale.x = dir
	hurtbox.scale.x = dir
	cs_idle.scale.x = dir
	cs_crouch.scale.x = dir

func DisableCollision() -> void:
	# Hitboxes de Ataque
	cs_punch_hit.disabled = true
	cs_punch_hit.visible = false
	
	# Hurtboxes de Dano
	cs_idle_hurt.disabled = true
	cs_idle_hurt.visible = false
	cs_crouch_hurt.disabled = true
	cs_crouch_hurt.visible = false

	# Hitbox player
	cs_idle.disabled = true
	cs_idle.visible = false
	
	cs_crouch.disabled = true
	cs_crouch.visible = false

# --- GERENCIADOR DE TRANSIÇÃO DE ESTADOS ---

func ChangeState(new_state: State) -> void:
	# Se estiver executando o soco, impede a troca de estado até finalizar
	if current_state == State.PUNCH and new_state != State.IDLE:
		return

	current_state = new_state

	match current_state:
		State.IDLE:
			DisableCollision()
			cs_idle.disabled = false
			cs_idle.visible = true
			cs_idle_hurt.disabled = false
			cs_idle_hurt.visible = true
			anim.play("idle")

		State.MOVE:
			DisableCollision()
			cs_idle.disabled = false
			cs_idle.visible = true
			cs_idle_hurt.disabled = false
			cs_idle_hurt.visible = true
			anim.play("walk")

		State.CROUCH:
			DisableCollision()
			velocity.x = 0
			cs_crouch.disabled = false
			cs_crouch.visible = true
			cs_crouch_hurt.disabled = false
			cs_crouch_hurt.visible = true
			anim.play("crouch")

		State.JUMP:
			DisableCollision()
			cs_idle.disabled = false
			cs_idle.visible = true
			cs_idle_hurt.disabled = false
			cs_idle_hurt.visible = true
			velocity.y = JUMP_VELOCITY
			anim.play("jump")

		State.FALL:
			DisableCollision()
			cs_idle.disabled = false
			cs_idle.visible = true
			cs_idle_hurt.disabled = false
			cs_idle_hurt.visible = true

		State.DASH:
			DisableCollision()
			cs_idle.disabled = false
			cs_idle.visible = true
			cs_idle_hurt.disabled = false
			cs_idle_hurt.visible = true
			dash_timer = DASH_DURATION
			dash_cooldown_timer = DASH_COOLDOWN
			velocity.y = 0
			anim.play("dash")

		State.PUNCH:
			velocity.x = 0
			$Attacks.WeakPunch()
			
			# Timer de segurança para evitar travamentos caso a animação falhe
			get_tree().create_timer(0.5).timeout.connect(func():
				if current_state == State.PUNCH:
					ChangeState(State.IDLE)
			, CONNECT_ONE_SHOT)
			anim.play("weak_punch")
			
		State.THROW:
			DisableCollision()
			cs_idle.disabled = false
			cs_idle.visible = true
			
			velocity.x = 0
			anim.play("throw")
			
		State.ULT:
			DisableCollision()
			velocity.x = 0
			$Attacks.Ult()
		


# --- CHECAGEM DE ATAQUES E COMPORTAMENTO ---

func CheckAttacks() -> bool:
	if Input.is_action_just_pressed(action_strong):
		ChangeState(State.THROW)
		return true
		
	if Input.is_action_just_pressed(action_weak):
		ChangeState(State.PUNCH)	
		return true

	if Input.is_action_just_pressed(action_ult):
		ChangeState(State.ULT)
		return true
		
	return false


func StateIdle() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)

	if CheckAttacks(): return
	
	if TryDash(): return
	if Input.is_action_just_pressed(action_jump) and is_on_floor():
		ChangeState(State.JUMP)
	elif Input.is_action_pressed(action_crouch) and is_on_floor():
		ChangeState(State.CROUCH)
	elif Input.get_axis(action_left, action_right) != 0:
		ChangeState(State.MOVE)
	elif not is_on_floor():
		ChangeState(State.FALL)


func StateMove() -> void:
	var direction := Input.get_axis(action_left, action_right)

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		ChangeState(State.IDLE)
		return

	if CheckAttacks(): return
	
	if TryDash(): return
	
	if Input.is_action_just_pressed(action_jump) and is_on_floor():
		ChangeState(State.JUMP)
	elif Input.is_action_pressed(action_crouch) and is_on_floor():
		ChangeState(State.CROUCH)
	elif not is_on_floor():
		ChangeState(State.FALL)


func StateCrouch() -> void:
	velocity.x = 0

	if CheckAttacks(): return
	if not Input.is_action_pressed(action_crouch):
		if Input.get_axis(action_left, action_right) != 0:
			ChangeState(State.MOVE)
		else:
			ChangeState(State.IDLE)


func StateJump() -> void:
	var direction := Input.get_axis(action_left, action_right)
	velocity.x = direction * SPEED
	
	if TryDash(): return
	if CheckAttacks(): return
	
	if velocity.y > 0:
		ChangeState(State.FALL)


func StateFall() -> void:
	var direction := Input.get_axis(action_left, action_right)
	velocity.x = direction * SPEED
	
	if TryDash(): return
	if CheckAttacks(): return
	
	if is_on_floor():
		if direction != 0:
			ChangeState(State.MOVE)
		else:
			ChangeState(State.IDLE)


func StateDash(delta: float) -> void:
	velocity.x = dash_direction * DASH_SPEED
	dash_timer -= delta

	if dash_timer <= 0:
		if is_on_floor():
			ChangeState(State.IDLE)
		else:
			ChangeState(State.FALL)


func StatePunch() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)

func StateThrow() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)
	
func StateUlt() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)

# --- CALLBACKS E SISTEMAS AUXILIARES ---

func _on_animation_finished() -> void:
	if current_state in [State.PUNCH, State.THROW, State.ULT]:
		ChangeState(State.IDLE)

	elif anim.animation == "weak_punch" or anim.animation == "crouch" or anim.animation == "dash":
		ChangeState(State.IDLE)

func _on_frame_changed() -> void:
	if current_state == State.THROW:
		var ultimo_frame = anim.sprite_frames.get_frame_count(anim.animation) - 1
		if anim.frame == ultimo_frame:
			$Attacks.Throw()


func TryDash() -> bool:
	var direction := Input.get_axis(action_left, action_right)
	if Input.is_action_just_pressed(action_dash) and dash_cooldown_timer <= 0 and direction != 0:
		dash_direction = direction
		ChangeState(State.DASH)
		return true
	return false


func OpponentCollision() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider and collider.is_in_group("Player") and collision.get_normal().y < 0:
			var slip_direction = 200.0 if global_position.x > collider.global_position.x else -200.0
			velocity.x = slip_direction
