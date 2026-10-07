extends Node2D

@export var atributos: Health
@export var health_bar: HealthBar1
@export var health_bar2: HealthBar2

func _ready():
	if get_parent():
		atributos = get_parent().Health
		
	if health_bar:
		health_bar.update_bar(get_parent().health, atributos.get_total_life())
		
func update_health_bar(current, max_health):
	if health_bar:
		health_bar.update_bar(current, max_health)	
		get_parent().health = current
