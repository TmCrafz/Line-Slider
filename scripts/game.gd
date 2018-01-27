extends Node2D

var screenSize
var blockSize
var blockColor

var wallTop
var wallBottom
var player

func _ready():
	screenSize = get_viewport_rect().size
	player = get_node("Player")
	
	blockSize = Vector2(120, 120)
	blockColor = Color(0.69, 0.09, 0.12)
	#var blockColor = Color(0.69, 0.89, 0.12)
	# Create top block
	wallTop = get_node("WallTop")
	wallBottom = get_node("WallBottom")
	wallTop.set_pos(Vector2(0, blockSize.y / 2.0))
	wallBottom.set_pos(Vector2(0, screenSize.y - blockSize.y / 2.0))
	for i in range(8):
		blockColor.r = (randf()*11+1) / 10.0
		blockColor.g = (randf()*11+1) / 10.0
		blockColor.b = (randf()*11+1) / 10.0
		createTopBlock()
		createBottomBlock()
#	# Create bottom block
#	wallBottom = get_node("WallBottom");
#	var wallBottomShape = get_node("WallBottom/Shape")
#	wallBottomShape.set_polygon(blockPols)
#	wallBottomShape.set_color(blockColor)
#	var collisionPolygonBottom = ConvexPolygonShape2D.new()
#	collisionPolygonBottom.set_points(blockPols)
#	wallBottom.add_shape(collisionPolygonBottom)
#	wallBottom.set_pos(Vector2(screenSize.x - blockSize.x / 2.0, screenSize.y - blockSize.y / 2.0))
	
	set_process(true)
	set_fixed_process(true)
	
func _process(delta):
	pass

func _fixed_process(delta):
	updateCamera()
	pass

# Remove the block which is most left
func removeBlock():
	var wallNodes = get_node("WallTop").get_children()
	wallTop.remove_child(wallNodes[0])
	pass

func createTopBlock():
	var wallNodes = get_node("WallTop").get_children()
	var startPos = Vector2(0, 0)
	if !wallNodes.empty():
		var lastWallNode = wallNodes.back()
		startPos.x += lastWallNode.get_pos().x + blockSize.x
	createBlock(startPos, wallTop)
	pass

func createBottomBlock():
	var wallNodes = get_node("WallBottom").get_children()
	var startPos = Vector2(0, 0)
	if !wallNodes.empty():
		var lastWallNode = wallNodes.back()
		startPos.x += lastWallNode.get_pos().x + blockSize.x
	createBlock(startPos, wallBottom)
	pass

func createBlock(startPos, wall):
	var blockPols = Vector2Array()
	blockPols.append(Vector2(-blockSize.x / 2.0, -blockSize.y / 2.0))
	blockPols.append(Vector2(blockSize.x / 2.0, -blockSize.y / 2.0))
	blockPols.append(Vector2(blockSize.x / 2.0, blockSize.y / 2.0))
	blockPols.append(Vector2(-blockSize.x / 2.0, blockSize.y / 2.0))
	
	var wallShape = Polygon2D.new()
	wallShape.set_pos(Vector2(startPos.x, 0))
	wall.add_child(wallShape)
	wallShape.set_polygon(blockPols)
	wallShape.set_color(blockColor)
	# Collision
	var blockPolsC = Vector2Array()
	blockPolsC.append(Vector2(-blockSize.x / 2.0 + startPos.x, -blockSize.y / 2.0))
	blockPolsC.append(Vector2(blockSize.x / 2.0 + startPos.x, -blockSize.y / 2.0))
	blockPolsC.append(Vector2(blockSize.x / 2.0 + startPos.x, blockSize.y / 2.0))
	blockPolsC.append(Vector2(-blockSize.x / 2.0 + startPos.x, blockSize.y / 2.0))
	var collisionPolygon = ConvexPolygonShape2D.new()
	collisionPolygon.set_points(blockPolsC)
	wall.add_shape(collisionPolygon)
	pass

func updateCamera():
#	print("updateCamera")
	var canvasTransform = get_viewport().get_canvas_transform()
	# The movement is inverted, like its like sliding a paper under a camera when modifying canvas transform 
	canvasTransform[2].x = -player.get_pos().x + screenSize.x / 2.0
	get_viewport().set_canvas_transform(canvasTransform)
	pass