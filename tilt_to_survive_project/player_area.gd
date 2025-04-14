extends Node2D
var start
var size
var radius =10

func _draw() -> void:
	start = %Player.playerAreaStart
	size = %Player.playerAreaSize
	var style_box = StyleBoxFlat.new()
	style_box.set_corner_radius_all(radius)
	draw_style_box(style_box, size)
	#draw_rect(size, Color.WHITE,false,4,true)

	#draw_rect(size,Color.GREEN,false,)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
