extends KinematicBody2D

signal move

var playerSize

var playerSpeed
var playerDirection

func _ready():
	var screenSize = get_viewport_rect().size
	
	
	playerSpeed = Vector2(180.0, 900.0)
	playerDirection = Vector2(1.0, 0.0)
	var playerColor = Color(0.10, 0.10, 0.44)
	playerSize = Vector2(80, 80)
	var playerPols = Vector2Array()
	playerPols.append(Vector2(-playerSize.x / 2.0, -playerSize.y / 2.0))
	playerPols.append(Vector2(playerSize.x / 2.0, -playerSize.y / 2.0))
	playerPols.append(Vector2(playerSize.x / 2.0, playerSize.y / 2.0))
	playerPols.append(Vector2(-playerSize.x / 2.0, playerSize.y / 2.0))
	var playerShape = get_node("Shape")
	playerShape.set_polygon(playerPols)
	playerShape.set_color(playerColor)
	var collisionPlayer = RectangleShape2D.new()
	collisionPlayer.set_extents(Vector2(playerSize.x / 2.0, playerSize.y / 2.0))
	add_shape(collisionPlayer)
	set_pos(Vector2(screenSize.x / 4.0, screenSize.y / 2.0))
	
	set_process(true)
	set_fixed_process(true)
	

func _process(delta):
	if (Input.is_action_pressed("move_down")):
		playerDirection.y = 1.0
	elif(Input.is_action_pressed("move_up")):
		playerDirection.y = -1.0

func _fixed_process(delta):
	var motion = Vector2(0, 0)
	motion.x = playerDirection.x * playerSpeed.x * delta
	motion.y = playerDirection.y * playerSpeed.y * delta
	move(motion)
	if (is_colliding()):
		var colNormal = get_collision_normal()
		motion = colNormal.slide(motion)
		move(motion)
		emit_signal("move")


