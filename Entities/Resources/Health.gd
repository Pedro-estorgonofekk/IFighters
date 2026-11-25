extends Node
class_name Health

signal healthCabo
signal tookDmg(dmgTaken, playerHealth)
signal healthMudou(currentHealth)

@export var maxHealth: int = 100
var playerHealth: int
var dead: bool = false

func _ready() -> void:
	playerHealth = maxHealth
	print(playerHealth)
	
func TakeDmg(damage: int):
	if dead:
		return
		
	playerHealth -= damage
	playerHealth = clampi(playerHealth, 0, maxHealth)
	tookDmg.emit(damage, playerHealth)
	healthMudou.emit(playerHealth)
	
	if playerHealth <= 0:
		healthCabo.emit()
		dead = true

func Heal(amount: int):
	if dead:
		return
		
	playerHealth += amount
	playerHealth = clampi(playerHealth, 0, maxHealth)
	healthMudou.emit(playerHealth)
