@tool
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_draw() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _draw() -> void:
	var accel = Sensors.get_accelerometer()
	draw_line(Vector2(0,0),Vector2(accel[1],accel[2]),Color.FIREBRICK,2)
