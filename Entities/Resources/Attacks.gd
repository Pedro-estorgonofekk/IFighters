class_name Attacks
extends Node

@onready var cooldown = $Timer

@export var weak_dmg: int
@export var strong_dmg: int
@export var ult_dmg: int
@export var projectile_dmg: int
@export var projectile: PackedScene

func WeakPunch():
	pass
	
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
