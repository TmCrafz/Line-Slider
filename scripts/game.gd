extends Node2D

var screenSize
var blockSize
var playerSize
# Horizontal speed of player
var playerHorSpeed

var blockTop
var blockBottom
var player

func _ready():
	screenSize = get_viewport_rect().size
	playerHorSpeed = 60.0
	# Create blocks
	blockSize = Vector2(screenSize.x, 120)
	var blockColor = Color(0.69, 0.09, 0.12)
	#var blockColor = Color(0.69, 0.89, 0.12)
	var blockPols = Vector2Array()
	blockPols.append(Vector2(0, 0))
	blockPols.append(Vector2(blockSize.x, 0))
	blockPols.append(Vector2(blockSize.x, blockSize.y))
	blockPols.append(Vector2(0, blockSize.y))
	# Create top block
	blockTop = get_node("WallTop")
	var blockTopShape = get_node("WallTop/Shape")
	blockTopShape.set_polygon(blockPols)
	blockTopShape.set_color(blockColor)
	var collisionPolygonTop = ConcavePolygonShape2D.new()
	collisionPolygonTop.set_segments(blockPols)
	blockTop.set_pos(Vector2(0, 0))
	blockTop.add_shape(collisionPolygonTop)
#	# Create bottom block
	blockBottom = get_node("WallBottom");
	var blockBottomShape = get_node("WallBottom/Shape")
	blockBottomShape.set_polygon(blockPols)
	blockBottomShape.set_color(blockColor)
	var collisionPolygonBottom = ConcavePolygonShape2D.new()
	collisionPolygonBottom.set_segments(blockPols)
	blockBottom.set_pos(Vector2(0, screenSize.y - blockSize.y))
	blockBottom.add_shape(collisionPolygonBottom)
	# Create player
	var playerColor = Color(0.10, 0.10, 0.44)
	playerSize = Vector2(80, 80)
	var playerPols = Vector2Array()
#	playerPols.append(Vector2(-playerSize.x / 2.0, -playerSize.y / 2.0))
#	playerPols.append(Vector2(playerSize.x / 2.0, -playerSize.y / 2.0))
#	playerPols.append(Vector2(playerSize.x / 2.0, playerSize.y / 2.0))
#	playerPols.append(Vector2(-playerSize.x / 2.0, playerSize.y / 2.0))
	playerPols.append(Vector2(0, 0))
	playerPols.append(Vector2(playerSize.x, 0))
	playerPols.append(Vector2(playerSize.x, playerSize.y))
	playerPols.append(Vector2(0, playerSize.y))
	
	var colPols = Vector2Array()
	colPols.append(Vector2(0, 0))
	colPols.append(Vector2(playerSize.x, 0))
	colPols.append(Vector2(playerSize.x, playerSize.y))
	colPols.append(Vector2(0, playerSize.y))
	player = get_node("Player")
	var playerShape = get_node("Player/Shape")
	playerShape.set_polygon(playerPols)
	playerShape.set_color(playerColor)
	var collisionPlayer = RectangleShape2D.new()
	collisionPlayer.set_extents(playerSize)
	player.add_shape(collisionPlayer)
	player.set_pos(Vector2(0, 300))
	set_process(true)
	set_fixed_process(true)
	
func _process(delta):
	pass
	
	
func _fixed_process(delta):
#	player.move(Vector2(playerHorSpeed * delta, delta * 100.0))
#	player.move(Vector2(0, delta * 100.0))
	player.move(Vector2(playerHorSpeed * delta))