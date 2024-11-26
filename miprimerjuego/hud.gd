extends CanvasLayer

# Notifica al nodo `Main` que el botón ha sido presionado
signal start_game

# Muestra un mensaje temporal
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

# Muestra "Game Over" y vuelve al título después de un breve tiempo
func show_game_over():
	show_message("Game Over")
	# Espera hasta que `MessageTimer` termine
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Crea un temporizador de un segundo y espera a que termine
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

# Actualiza el puntaje en `ScoreLabel`
func update_score(score):
	$ScoreLabel.text = str(score)

# Se llama cuando el botón de inicio es presionado
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

# Se llama cuando `MessageTimer` termina
func _on_message_timer_timeout():
	$Message.hide()
