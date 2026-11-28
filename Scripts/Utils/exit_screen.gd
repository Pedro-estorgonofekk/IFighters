extends ColorRect

var fechando := false
var pos_final := Vector2.ZERO
var tween_entrada: Tween

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	animate_in()
	$Sim.grab_focus()

# --- Entrada ---
func animate_in() -> void:
	pos_final = position

	modulate.a = 0.0
	scale = Vector2(0.75, 0.75)
	pivot_offset = size / 2.0
	position = pos_final - Vector2(0, 20)

	tween_entrada = create_tween().set_parallel(true)
	tween_entrada.tween_property(self, "modulate:a", 1.0, 0.2)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween_entrada.tween_property(self, "scale", Vector2.ONE, 0.4)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween_entrada.tween_property(self, "position", pos_final, 0.3)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	var i := 0
	for filho in get_children():
		if filho is Control:
			var alvo := 0.6 if filho.has_focus() else 1.0
			filho.modulate.a = 0.0
			tween_entrada.tween_property(filho, "modulate:a", alvo, 0.2)\
				.set_delay(0.1 + 0.06 * i)
			i += 1

# --- Saída (devolve quando terminou) ---
func animate_out() -> void:
	if tween_entrada:
		tween_entrada.kill()   # para a entrada se ainda estiver rodando
	pivot_offset = size / 2.0

	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "modulate:a", 0.0, 0.18)
	tween.tween_property(self, "scale", Vector2(0.85, 0.85), 0.18)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", pos_final + Vector2(0, 15), 0.18)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	await tween.finished

func fechar() -> void:
	if fechando:
		return
	fechando = true
	await animate_out()
	get_tree().paused = false
	queue_free()

# --- Botões ---
func _on_sim_pressed() -> void:
	if fechando:
		return
	fechando = true
	await animate_out()
	get_tree().quit()

func _on_nao_pressed() -> void:
	fechar()

func _exit_tree() -> void:
	get_tree().paused = false
