extends Node2D

var screenSize
var blockSize
var playerSize

var playerSpeed
var playerDirection

var blockTop
var blockBottom
var player

func _ready():
	screenSize = get_viewport_rect().size
	playerSpeed = Vector2(60.0, 360.0)
	playerDirection = Vector2(1.0, 0.0)
	# Create blocks
	blockSize = Vector2(screenSize.x, 120)
	var blockColor = Color(0.69, 0.09, 0.12)
	#var blockColor = Color(0.69, 0.89, 0.12)
	var blockPols = Vector2Array()
	blockPols.append(Vector2(-blockSize.x / 2.0, -blockSize.y / 2.0))
	blockPols.append(Vector2(blockSize.x / 2.0, -blockSize.y / 2.0))
	blockPols.append(Vector2(blockSize.x / 2.0, blockSize.y / 2.0))
	blockPols.append(Vector2(-blockSize.x / 2.0, blockSize.y / 2.0))
	# Create top block
	blockTop = get_node("WallTop")
	blockTop.set_pos(Vector2(blockSize.x / 2.0, blockSize.y / 2.0))
	var blockTopShape = get_node("WallTop/Shape")
	blockTopShape.set_polygon(blockPols)
	blockTopShape.set_color(blockColor)
	var collisionPolygonTop = ConvexPolygonShape2D.new()
	collisionPolygonTop.set_points(blockPols)
	
	blockTop.add_shape(collisionPolygonTop)
#	# Create bottom block
	blockBottom = get_node("WallBottom");
	var blockBottomShape = get_node("WallBottom/Shape")
	blockBottomShape.set_polygon(blockPols)
	blockBottomShape.set_color(blockColor)
	var collisionPolygonBottom = RectangleShape2D.new()
	collisionPolygonBottom.set_extents(blockSize / 2.0)
	blockBottom.add_shape(collisionPolygonBottom)
	blockBottom.set_pos(Vector2(screenSize.x - blockSize.x / 2.0, screenSize.y - blockSize.y / 2.0))
	
	# Create player
	var playerColor = Color(0.10, 0.10, 0.44)
	playerSize = Vector2(80, 80)
	var playerPols = Vector2Array()
	playerPols.append(Vector2(-playerSize.x / 2.0, -playerSize.y / 2.0))
	playerPols.append(Vector2(playerSize.x / 2.0, -playerSize.y / 2.0))
	playerPols.append(Vector2(playerSize.x / 2.0, playerSize.y / 2.0))
	playerPols.append(Vector2(-playerSize.x / 2.0, playerSize.y / 2.0))
	player = get_node("Player")
	var playerShape = get_node("Player/Shape")
	playerShape.set_polygon(playerPols)
	playerShape.set_color(playerColor)
	var collisionPlayer = RectangleShape2D.new()
	collisionPlayer.set_extents(Vector2(playerSize.x / 2.0, playerSize.y / 2.0))
	player.add_shape(collisionPlayer)
	player.set_pos(Vector2(0, 300))
	set_process(true)
	set_fixed_process(true)
	
func _process(delta):
	if (Input.is_action_pressed("move_down")):
		playerDirection.y = 1.0
	elif(Input.is_action_pressed("move_up")):
		playerDirection.y = -1.0
	
	
func _fixed_process(delta):
#	player.move(Vector2(playerHorSpeed * delta, delta * 100.0))
#	player.move(Vector2(0, delta * 100.0))
	player.move(Vector2(playerDirection.x * playerSpeed.x * delta, playerDirection.y * playerSpeed.y * delta))
#	if (player.is_colliding()):
#		player.set_pos(player.get_collision_pos())