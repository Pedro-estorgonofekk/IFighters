extends Node2D
class_name Player

# Exporta variaveis para o reuso
@export var health = 100
@export var charName : String
@export var hurtbox: Area2D
@export var progressBar: ProgressBar

# Método de entrada, toda vez q for estanciada a primeira coisa a ser exec
func _ready():
	progressBar.max_value = health
	progressBar.value = health

# Metodo de tomar dano
func DamageTaken(damage):
	health -= damage
	if health < 1:
		queue_free()
