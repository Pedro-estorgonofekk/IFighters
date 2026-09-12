class_name Attacks
extends Node

@export var weak_dmg: int
@export var strong_dmg: int
@export var projectile_dmg: int
@export var projectile: PackedScene

func Throw():
	if projectile != null:
		var proj = projectile.instantiate()
		proj.global_position = get_parent().global_position
		get_tree().current_scene.add_child(proj)
		
