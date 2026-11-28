extends ColorRect

var fechando := false

func _ready() -> void:
	$TextureRect/Button.grab_focus()
	_animar_entrada()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		fechar()

# --- Animação ---
func _animar_entrada() -> void:
	var painel: Control = $TextureRect
	var cor_fundo := color.a
	var pos := painel.position

	# estado inicial
	color.a = 0.0
	painel.pivot_offset = painel.size / 2
	painel.modulate.a = 0.0
	painel.scale = Vector2(0.8, 0.8)
	painel.position = pos + Vector2(0, 30)

	var tw := create_tween().set_parallel(true)
	tw.tween_property(self, "color:a", cor_fundo, 0.2)
	tw.tween_property(painel, "modulate:a", 1.0, 0.2)
	tw.tween_property(painel, "scale", Vector2.ONE, 0.4)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tw.tween_property(painel, "position", pos, 0.3)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	# o conteúdo do painel aparece um após o outro
	var i := 0
	for filho in painel.get_children():
		if filho is Control:
			filho.modulate.a = 0.0
			tw.tween_property(filho, "modulate:a", 1.0, 0.2)\
				.set_delay(0.12 + 0.05 * i)
			i += 1

func fechar() -> void:
	if fechando:
		return
	fechando = true
	var painel: Control = $TextureRect
	painel.pivot_offset = painel.size / 2

	var tw := create_tween().set_parallel(true)
	tw.tween_property(self, "color:a", 0.0, 0.18)
	tw.tween_property(painel, "modulate:a", 0.0, 0.18)
	tw.tween_property(painel, "scale", Vector2(0.9, 0.9), 0.18)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tw.tween_property(painel, "position", painel.position + Vector2(0, 20), 0.18)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	await tw.finished
	queue_free()
