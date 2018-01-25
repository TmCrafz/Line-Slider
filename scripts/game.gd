extends Node2D

var screenSize
var blockSize

var wallTop
var wallBottom
var player
var camera

func _ready():
	screenSize = get_viewport_rect().size
	
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
	wallTop = get_node("WallTop")
	wallTop.set_pos(Vector2(blockSize.x / 2.0, blockSize.y / 2.0))
	var wallTopShape = get_node("WallTop/Shape")
	wallTopShape.set_polygon(blockPols)
	wallTopShape.set_color(blockColor)
	var collisionPolygonTop = ConvexPolygonShape2D.new()
	collisionPolygonTop.set_points(blockPols)
	
	wallTop.add_shape(collisionPolygonTop)
#	# Create bottom block
	wallBottom = get_node("WallBottom");
	var wallBottomShape = get_node("WallBottom/Shape")
	wallBottomShape.set_polygon(blockPols)
	wallBottomShape.set_color(blockColor)
	var collisionPolygonBottom = ConvexPolygonShape2D.new()
	collisionPolygonBottom.set_points(blockPols)
	wallBottom.add_shape(collisionPolygonBottom)
	wallBottom.set_pos(Vector2(screenSize.x - blockSize.x / 2.0, screenSize.y - blockSize.y / 2.0))
	
	camera = get_node("Camera")
	camera.set_pos(screenSize / 2.0)
	
	set_process(true)
	set_fixed_process(true)
	
func _process(delta):
	# Update camera
	var camera = get_node("Camera")
	#camera.set_pos(Vector2(player.get_pos().x, camera.get_pos().y))
	
	
func _fixed_process(delta):
	pass
