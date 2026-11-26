extends ColorRect

var fechando := false
var pronto := false   # só aceita fechar depois que a entrada termina

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_animar_entrada()

func _process(_delta: float) -> void:
	if pronto and Input.is_action_just_pressed("ui_cancel"):
		fechar()

func _animar_entrada() -> void:
	pivot_offset = size / 2
	modulate.a = 0.0
	scale = Vector2(0.9, 0.9)
	var tw := create_tween().set_parallel(true)
	tw.tween_property(self, "modulate:a", 1.0, 0.2)
	tw.tween_property(self, "scale", Vector2.ONE, 0.25)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	await tw.finished
	pronto = true

func fechar() -> void:
	if fechando:
		return
	fechando = true
	pivot_offset = size / 2
	var tw := create_tween().set_parallel(true)
	tw.tween_property(self, "modulate:a", 0.0, 0.15)
	tw.tween_property(self, "scale", Vector2(0.9, 0.9), 0.15)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	await tw.finished
	queue_free()

func _exit_tree() -> void:
	get_tree().paused = false
