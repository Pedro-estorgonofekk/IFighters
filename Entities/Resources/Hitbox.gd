class_name Hitbox
extends Area2D

@onready var stamina = $"../Attacks/Stamina"

var damage := 1: set = SetDmg, get = GetDmg

func SetDmg(value: int):
	damage = value
	
func GetDmg() -> int:
	return damage

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Hurtbox":
		var target = area.get_parent()
		var health_node = target.get_node_or_null("Health")
		stamina.Increase(stamina.regen_rate)
		
		if health_node:
			health_node.TakeDmg(damage)
			get_node("CSPunchHit").set_deferred("disabled", true)
