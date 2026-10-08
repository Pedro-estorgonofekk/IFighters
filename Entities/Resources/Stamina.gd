class_name Stamina
extends Node

signal StaminaChanged(current: float, max_stamina: float)
signal StaminaExhausted

@export var max_stamina: float = 100.0
@export var regen_rate: float
var current_stamina: float

func _ready() -> void:
	current_stamina = max_stamina
	
func HasStamina(amount: float):
	return current_stamina >= amount

func Consume(amount: float):
	if HasStamina(amount):
		current_stamina -= amount
		StaminaChanged.emit(current_stamina, max_stamina)
		print("Stamina:", current_stamina)
		
		if current_stamina <= 0:
			StaminaExhausted.emit()
		return true
		
	return false
	
func Increase(amount: float):
	current_stamina += amount
	current_stamina = clampf(current_stamina, 0, max_stamina)
	
	StaminaChanged.emit(current_stamina, max_stamina)
	
	return current_stamina
