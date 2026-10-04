class_name Stamina
extends Node

signal staminaChanged(current: float, max_stamina: float)
signal staminaExhausted

@export var max_stamina: float = 100.0
@export var regen_rate: float
var current_stamina: float

func _ready() -> void:
	current_stamina = max_stamina
