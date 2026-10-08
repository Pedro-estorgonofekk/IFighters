extends ColorRect

func _ready() -> void:
	# Anima a entrada assim que o popup surge na tela
	animate_in()

func animate_in() -> void:
	# Prepara o estado inicial (transparente e ligeiramente menor)
	modulate.a = 0.0
	scale = Vector2(0.8, 0.8)
	pivot_offset = size / 2.0  # Garante que a escala expanda a partir do centro
	
	# Anima opacidade e tamanho ao mesmo tempo
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "modulate:a", 1.0, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2.ONE, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_sim_pressed() -> void:
	get_tree().quit()

func _on_nao_pressed() -> void:
	# Anima a saída suavemente antes de remover o nó
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "modulate:a", 0.0, 0.15)
	tween.tween_property(self, "scale", Vector2(0.8, 0.8), 0.15)
	
	# Aguarda a animação terminar
	await tween.finished
	
	get_tree().paused = false
	self.queue_free()
