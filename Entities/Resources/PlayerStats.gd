extends Node
class_name Health

signal healthDepleted
signal tomouDano(dmgTaken, playerHealth)

@export var maxHealth: int = 100
var playerHealth: int

func _ready() -> void:
	playerHealth = maxHealth

func tomar_dano(damage: int) -> void:
	playerHealth -= damage
	#clampi é pra vida n sair do limite de 0-100
	playerHealth = clampi(playerHealth, 0, playerHealth) 
	tomouDano.emit(damage, playerHealth) 
	
	if playerHealth == 0:
		healthDepleted.emit()
