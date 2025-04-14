extends Area2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size
var playerAreaStart
var playerAreaEnd 
var playerAreaSize
var hitbox_radius
var hitbox

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size= get_viewport_rect().size  # Size of the game window
	var space=30
	playerAreaStart =Vector2(space,space)
	playerAreaEnd = Vector2(screen_size.x,screen_size.y)-Vector2(space,space)
	playerAreaSize = Rect2(playerAreaStart,Vector2(screen_size.x,screen_size.y)-2*Vector2(space,space))
	hitbox_radius = $CollisionShape2D.shape.radius*1.5
	hitbox = Vector2(hitbox_radius,hitbox_radius)
	hide()

func clamp(num,minval,maxval):
	if num<minval:
		return minval
	elif num>maxval:
		return maxval
	return num
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	var accel = Sensors.get_accelerometer()
	var magnitudo = Vector2.ZERO
	
	var hrange = 30 #deg*2 = 60 [-30,30]
	var vrange = 40 #deg*2 = 80 [-40,40]
	
	var x
	var y
	
	#to clamp the range to the given interval
	x =-clamp(accel[1],-hrange,hrange)
	y = clamp(accel[2],-vrange,vrange)
	
	#the acceleration is based on gravity force
	var gravity_constant= 9.81
	
	magnitudo.x += exp(abs(x)/3)/hrange * sign(x) #cos(x)*gravity_constant # #9.0*pow(x,2)/pow(hrange,2)
	magnitudo.y += exp(abs(y)/3)/vrange * sign(y) #cos(y)*gravity_constant # #9.0*pow(y,2)/pow(vrange,2)

#if OS.has_feature("web_linuxbsd") or OS.has_feature("web_macos") or OS.has_feature("web_windows") or OS.has_feature("linuxbsd") : #USES ACCELEROMETER
	
	if Input.is_action_pressed("move_right"):
		magnitudo.x += 1
	if Input.is_action_pressed("move_left"):
		magnitudo.x -= 1
	if Input.is_action_pressed("move_up"):
		magnitudo.y -= 1
	if Input.is_action_pressed("move_down" ):
		magnitudo.y += 1
	

	if magnitudo.length()>1:
		magnitudo = magnitudo.normalized() * speed
	#	$AnimatedSprite2D.play()
	else:
		magnitudo = magnitudo * speed
	#	$AnimatedSprite2D.stop()
	
	position += magnitudo * delta
	
	position = position.clamp(playerAreaStart+hitbox,playerAreaEnd-hitbox)
	
	$Arrow.rotation=magnitudo.angle()
	
	#if velocity.x != 0:
	#	$AnimatedSprite2D.animation = "move"
	#	$AnimatedSprite2D.flip_v = false
	#	
	#	$AnimatedSprite2D.flip_h = velocity.x < 0
	#else:
	#	$AnimatedSprite2D.animation = "up"	
	#	$AnimatedSprite2D.flip_v = velocity.y > 0
		


func _on_body_entered(_body):
	hide()
	hit.emit()
		# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled",true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
