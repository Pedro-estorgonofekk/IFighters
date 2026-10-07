extends Node
class_name Health

signal healthCabo
signal tookDmg(dmgTaken, playerHealth)
signal healthMudou(currentHealth)

@export var maxHealth: int = 100
var playerHealth: int

func _ready() -> void:
	playerHealth = maxHealth
	print(playerHealth)
	
func TakeDmg(damage: int):
	playerHealth -= damage
	playerHealth = clampi(playerHealth, 0, maxHealth)
	tookDmg.emit(damage, playerHealth)
	healthMudou.emit(playerHealth)
	
	if playerHealth <= 0:
		healthCabo.emit()
		print("Emiti")

func Heal(amount: int):
	playerHealth += amount
	playerHealth = clampi(playerHealth, 0, maxHealth)
	healthMudou.emit(playerHealth)
