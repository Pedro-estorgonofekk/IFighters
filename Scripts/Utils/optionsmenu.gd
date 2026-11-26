extends ColorRect

var fechando := false
var pronto := false   # só aceita fechar depois que a animação de entrada termina

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true

	$TextureRect/SliderGeral.set_value_no_signal(_ler_bus("Master"))
	$TextureRect/SliderSFX.set_value_no_signal(_ler_bus("SFX"))
	$TextureRect/SliderMusica.set_value_no_signal(_ler_bus("Music"))
	$TextureRect/BtnControles.grab_focus()

	_animar_entrada()

func _process(_delta: float) -> void:
	if pronto and Input.is_action_just_pressed("ui_cancel"):
		fechar()

# --- Volume: cada slider controla o bus dele; o Master afeta os outros sozinho ---
func _ler_bus(nome: String) -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(nome)))

func _set_bus(nome: String, valor: float) -> void:
	var bus := AudioServer.get_bus_index(nome)
	AudioServer.set_bus_volume_db(bus, linear_to_db(valor))
	AudioServer.set_bus_mute(bus, valor <= 0.0)

# --- Animação ---
func _animar_entrada() -> void:
	var painel: Control = $TextureRect
	painel.pivot_offset = painel.size / 2
	modulate.a = 0.0
	painel.scale = Vector2(0.85, 0.85)
	var tw := create_tween().set_parallel(true)
	tw.tween_property(self, "modulate:a", 1.0, 0.2)
	tw.tween_property(painel, "scale", Vector2.ONE, 0.25)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	await tw.finished
	pronto = true

func fechar() -> void:
	if fechando:
		return
	fechando = true
	var painel: Control = $TextureRect
	painel.pivot_offset = painel.size / 2
	var tw := create_tween().set_parallel(true)
	tw.tween_property(self, "modulate:a", 0.0, 0.15)
	tw.tween_property(painel, "scale", Vector2(0.85, 0.85), 0.15)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	await tw.finished
	queue_free()

# --- Botão de controles ---
func _on_btn_controles_focus_entered() -> void:
	$TextureRect/BtnControles.modulate.a = 0.6

func _on_btn_controles_focus_exited() -> void:
	$TextureRect/BtnControles.modulate.a = 1.0

# --- Sliders ---
func _on_slider_geral_value_changed(value: float) -> void:
	_set_bus("Master", value)

func _on_slider_sfx_value_changed(value: float) -> void:
	_set_bus("SFX", value)

func _on_slider_musica_value_changed(value: float) -> void:
	_set_bus("Music", value)

func _exit_tree() -> void:
	get_tree().paused = false
