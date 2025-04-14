extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_direction(player_pos):
#	if self.position != null and $Player.position != null :
	var direction = Vector2(player_pos-self.position).normalized().angle()
	 
	#direction += randf_range(-PI/4,PI/4)
	self.rotation = direction
	var vel = Vector2(self.linear_velocity.length(),0)
	self.linear_velocity = vel.rotated(direction)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
