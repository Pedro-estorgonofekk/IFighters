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
@onready var anim := get_parent().get_node("AnimatedSprite2D")

func WeakPunch():
	if cooldown.is_stopped():
		cs_punch_hit.disabled = false
		cs_punch_hit.visible = true
		hitbox.damage = weak_dmg
		cooldown.start()
		
func StrgPunch():
	pass

func Ult():
	if ultimate != null and cooldown.is_stopped():
		var ult = ultimate.instantiate()
		ult.collision_layer = hitbox.collision_layer
		ult.collision_mask = hitbox.collision_mask
		ult.damage = ult_dmg
		
		if anim.flip_h == true:
			ult.direction = -1
			ult.global_position = Vector2(1100, 415)
			ult.get_node("AnimatedSprite2D").flip_h = true
		else:
			ult.direction = 1
			ult.global_position = Vector2(-100, 415)
		
		
		get_tree().current_scene.add_child(ult)
		print(ult.global_position)
		cooldown.start()
		
func Throw() -> void:
	if projectile != null and cooldown.is_stopped():
		var proj = projectile.instantiate()
		
		proj.collision_layer = hitbox.collision_layer
		proj.collision_mask = hitbox.collision_mask
		proj.damage = projectile_dmg
		
		if anim.flip_h == true:
			proj.direction = -1
		else:
			proj.direction = 1
			
		proj.global_position = get_parent().global_position
		get_tree().current_scene.add_child(proj)
		
		cooldown.start()
