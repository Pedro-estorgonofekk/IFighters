class_name Attacks
extends Node

@onready var cooldown = $Cooldown

#Variaveis gerais e especificas dos ataques
@export var weak_dmg: int
@export var ult_dmg: int
@export var projectile_dmg: int
@export var projectile: PackedScene
@export var ultimate: PackedScene

@onready var hitbox := get_parent().get_node("Hitbox")
@onready var cs_punch_hit := get_parent().get_node("Hitbox/CSPunchHit")
@onready var cs_ult_hit := get_parent().get_node("Hitbox/CSUltHit")
@onready var anim := get_parent().get_node("AnimatedSprite2D")

#@onready var current_state = get_parent().current_state
#cs_punch_hit.disabled = false
#cs_punch_hit.visible = true
		

func WeakPunch():
	if cooldown.is_stopped():
		anim.play("weak_punch")
		cs_punch_hit.disabled = false
		cs_punch_hit.visible = true
		hitbox.damage = weak_dmg
		cooldown.start()
		
func StrgPunch():
	pass

func Ult():
	if ultimate != null and cooldown.is_stopped():
		var ult = ultimate.instantiate()
		var sprite = get_parent().get_node("AnimatedSprite2D")
		
		if sprite.flip_h == true:
			ult.direction = -1
			ult.global_position = Vector2(1100, 415)
			ult.get_node("AnimatedSprite2D").flip_h = true
		else:
			ult.direction = 1
			ult.global_position = Vector2(-100, 415)
		
		ult.damage = ult_dmg
		
		get_tree().current_scene.add_child(ult)
		print(ult.global_position)
		cooldown.start()
		
func Throw():
	if projectile != null and cooldown.is_stopped():
		var proj = projectile.instantiate()
		var sprite = get_parent().get_node("AnimatedSprite2D")
		
		if sprite.flip_h == true:
			proj.direction = -1
		else:
			proj.direction = 1
		
		proj.damage = projectile_dmg
		proj.global_position = get_parent().global_position
		
		get_tree().current_scene.add_child(proj)
		
		
		cooldown.start()
