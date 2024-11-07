extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text=text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	
	await($MessageTimer.timeout)
	
	$Message.text="Tilt to survive!"
	$Message.show()
	
	await(get_tree().create_timer(1.0).timeout)
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text=str(score)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var accel = Sensors.get_accelerometer()
	
	update_xyz(accel) 

func update_xyz(accel):
	$Control/X_value.text = str(int(accel[0])) #str(float($Control/X_value.text)+x)
	$Control/Y_value.text = str(int(accel[1])) #str(float($Control/Y_value.text)+y)
	$Control/Z_value.text = str(int(accel[2])) #str(float($Control/Z_value.text)+z)


func _on_start_button_pressed():
	$StartButton.hide()
	Sensors.get_permission()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()


func _on_button_button_up() -> void:
	$Control/Z_value.text = str(float($Control/Z_value.text)+1)
