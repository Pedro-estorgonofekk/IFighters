extends Node2D

@onready var caster: CharacterBody2D
@onready var hope := $HopeUltimate
@onready var vault := $Vault
@onready var enemy = caster.opponent

@export var damage: int = 100

var speed = 20
var ult_layer
var ult_mask

func _ready() -> void:
	hope.global_position = caster.global_position + Vector2(44, -254)
	vault.global_position = enemy.global_position + Vector2(0, -467)
	vault.collision_layer = ult_layer
	vault.collision_mask = ult_mask
	
func _process(delta: float) -> void:
	speed *= 1.1
	vault.global_position.y += delta * speed
	
	if vault.global_position.y >= 440:
		speed = 0
		
		await get_tree().create_timer(1).timeout
		self.queue_free()


func _on_vault_area_entered(area: Area2D) -> void:
	if area.name == "Hurtbox":
		var target = area.get_parent()
		var health_node = target.get_node_or_null("Health")
		
		if health_node:
			health_node.TakeDmg(damage)
			get_node("Vault").get_node("CollisionShape2D").set_deferred("disabled", true)
