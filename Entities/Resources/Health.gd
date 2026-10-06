extends Node
class_name Health

signal healthDepleted
signal tookDmg(dmgTaken, playerHealth)

@export var maxHealth: int = 100
var playerHealth: int

func _ready() -> void:
	playerHealth = maxHealth
	print(playerHealth)
	
func TakeDmg(damage: int):
	playerHealth -= damage
	playerHealth = clampi(playerHealth, 0, maxHealth)
	tookDmg.emit(damage, playerHealth) 
	
	if playerHealth <= 0:
		healthDepleted.emit()
		print("Emiti")

func Heal(amount: int):
	playerHealth += amount
	playerHealth = clampi(playerHealth, 0, maxHealth)
