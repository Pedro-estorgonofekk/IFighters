class_name Hitbox
extends Area2D

@export var damage := 1: set = SetDmg, get = GetDmg

func SetDmg(value: int):
	damage = value
	
func GetDmg() -> int:
	return damage
