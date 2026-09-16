class_name Attacks
extends Node

@onready var cooldown = $Timer

#Variaveis gerais e especificas dos ataques
@export var weak_dmg: int
@export var strong_dmg: int
@export var ult_dmg: int
@export var projectile_dmg: int
@export var projectile: PackedScene

var cs_punch_hit: CollisionShape2D
var cs_
"DisableCollision()
		
		cs_idle_hurt.disabled = false
		cs_idle_hurt.visible = true
		
		cs_punch_hit.disabled = false
		cs_punch_hit.visible = true
		"
var anim: AnimatedSprite2D

func WeakPunch():
	anim = get_parent().get_node("AnimatedSprite2D")
	anim.play("weak_punch")
	print("tamo indo")
	
func StrgPunch():
	pass

func Ult():
	pass

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
