extends ColorRect

var fechando := false
var pronto := false   # só aceita fechar depois que a entrada termina
var pos_final := Vector2.ZERO

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_animar_entrada()

func _process(_delta: float) -> void:
	if pronto and Input.is_action_just_pressed("ui_cancel"):
		fechar()

func _animar_entrada() -> void:
	pos_final = position
	pivot_offset = size / 2

	# estado inicial: transparente, menor e um pouco abaixo
	modulate.a = 0.0
	scale = Vector2(0.85, 0.85)
	position = pos_final + Vector2(0, 30)

	var tw := create_tween().set_parallel(true)
	tw.tween_property(self, "modulate:a", 1.0, 0.25)
	tw.tween_property(self, "scale", Vector2.ONE, 0.4)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tw.tween_property(self, "position", pos_final, 0.35)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	# o conteúdo (textos, imagens) aparece um após o outro
	var i := 0
	for filho in get_children():
		if filho is Control:
			filho.modulate.a = 0.0
			tw.tween_property(filho, "modulate:a", 1.0, 0.25)\
				.set_delay(0.12 + 0.07 * i)
			i += 1

	await tw.finished
	pronto = true

func fechar() -> void:
	if fechando:
		return
	fechando = true
	pivot_offset = size / 2

	var tw := create_tween().set_parallel(true)
	tw.tween_property(self, "modulate:a", 0.0, 0.18)
	tw.tween_property(self, "scale", Vector2(0.92, 0.92), 0.18)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tw.tween_property(self, "position", pos_final + Vector2(0, 20), 0.18)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	await tw.finished
	queue_free()

func _exit_tree() -> void:
	get_tree().paused = false
