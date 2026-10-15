extends Node2D

@onready var caster: CharacterBody2D
@onready var hope := $HopeUltimate
@onready var vault := $Vault
@onready var enemy = caster.opponent

@export var damage: int = 100

var speed := 20.0
var ground := false
var ult_layer
var ult_mask

func _ready() -> void:
	if caster.get_node("AnimatedSprite2D").flip_h:
		hope.global_position = caster.global_position + Vector2(-44, -254)
	else:
		hope.global_position = caster.global_position + Vector2(44, -254)
		
	vault.global_position = enemy.global_position + Vector2(0, -467)
	
	vault.collision_layer = ult_layer
	vault.collision_mask = ult_mask
	
func _process(delta: float) -> void:
	if ground:
		return
	
	speed *= 1.09
	vault.global_position.y += delta * speed
	
	if vault.global_position.y >= 440:
		speed = 0
		ground = true
		vault.get_node("CPUParticles2D").emitting = true
		get_tree().call_group("Camera", "ApplyShake", 5)
		FadeOut()


func _on_vault_area_entered(area: Area2D) -> void:
	if area.name == "Hurtbox":
		var target = area.get_parent()
		var health_node = target.get_node_or_null("Health")
		
		target.ApplyHitstop(0.2)
		
		if health_node:
			health_node.TakeDmg(damage)
			get_node("Vault").get_node("CollisionShape2D").set_deferred("disabled", true)


func FadeOut():
	var tween = create_tween()
	
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	tween.tween_callback(self.queue_free)
