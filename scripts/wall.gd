extends Node

class Block:
	enum TYPE{ FULL, EMPTY }
	
	var m_body
	var m_type
	
	# Create a block of type FULL
	func _createFull(blockSize):
		var blockColor = Color(1.0, 1.0, 1.0, 1.0)
		blockColor.r = (randf()*11+1) / 10.0
		blockColor.g = (randf()*11+1) / 10.0
		blockColor.b = (randf()*11+1) / 10.0
		
		m_body = StaticBody2D.new()
		var blockPols = Vector2Array()
		blockPols.append(Vector2(-blockSize.x / 2.0, -blockSize.y / 2.0))
		blockPols.append(Vector2(blockSize.x / 2.0, -blockSize.y / 2.0))
		blockPols.append(Vector2(blockSize.x / 2.0, blockSize.y / 2.0))
		blockPols.append(Vector2(-blockSize.x / 2.0, blockSize.y / 2.0))
		
		var wallShape = Polygon2D.new()
		wallShape.set_pos(Vector2(0, 0))
		m_body.add_child(wallShape)
		wallShape.set_polygon(blockPols)
		wallShape.set_color(blockColor)
		# Collision
		var blockPolsC = Vector2Array()
		blockPolsC.append(Vector2(-blockSize.x / 2.0, -blockSize.y / 2.0))
		blockPolsC.append(Vector2(blockSize.x / 2.0, -blockSize.y / 2.0))
		blockPolsC.append(Vector2(blockSize.x / 2.0, blockSize.y / 2.0))
		blockPolsC.append(Vector2(-blockSize.x / 2.0, blockSize.y / 2.0))
		var collisionPolygon = ConvexPolygonShape2D.new()
		collisionPolygon.set_points(blockPolsC)
		m_body.add_shape(collisionPolygon)
		setType(TYPE.FULL)
	
	func _createEmpty(blockSize):
		m_body = StaticBody2D.new()
		setType(TYPE.EMPTY)
	
	func create(blockSize):
		# Random number between 1 and 3
		var rand = randi() % 3 + 1
		print("Rand: " + str(rand))
		if rand == 1 || rand == 2 || rand == 3:
			_createFull(blockSize)
		else:
			_createEmpty(blockSize)
	
	func setBody(body):
		m_body = body
		
	func getBody():
		return m_body
	
	func setType(type):
		m_type = type
	
	func getType():
		return m_type

onready var screenSize = get_viewport().get_rect().size
var blockSize = Vector2(120, 120)

onready var wallTop = get_node("WallTop")
onready var wallBottom = get_node("WallBottom")
onready var player = get_tree().get_root().get_node("game/Player")


func _ready():
	wallTop.set_pos(Vector2(0, blockSize.y / 2.0))
	wallBottom.set_pos(Vector2(0, screenSize.y - blockSize.y / 2.0))
	for i in range(8):
		createTopBlock()
		createBottomBlock()
	set_process(true)
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if isBlockSpawnNecessary():
		removeBlocks()
		createTopBlock()
		createBottomBlock()
	pass

# Remove the blocks which are most left
func removeBlocks():
	var wallNodesTop = wallTop.get_children()
	wallTop.remove_child(wallNodesTop[0])
	var wallNodesBottom = wallBottom.get_children()
	wallBottom.remove_child(wallNodesBottom[0])
	pass

func createTopBlock():
	var wallNodes = wallTop.get_children()
	var startPos = Vector2(0, 0)
	if !wallNodes.empty():
		var lastWallNode = wallNodes.back()
		startPos.x += lastWallNode.get_pos().x + blockSize.x
	var blockNew = Block.new()
	blockNew.create(blockSize)
	blockNew.getBody().set_pos(startPos)
	wallTop.add_child(blockNew.getBody())
	pass

func createBottomBlock():
	var wallNodes = wallBottom.get_children()
	var startPos = Vector2(0, 0)
	if !wallNodes.empty():
		var lastWallNode = wallNodes.back()
		startPos.x += lastWallNode.get_pos().x + blockSize.x
	var blockNew = Block.new()
	blockNew.create(blockSize)
	blockNew.getBody().set_pos(startPos)
	wallBottom.add_child(blockNew.getBody())
	pass

func isBlockSpawnNecessary():
	# Here it no matter if we use the top or bottom wall, because count of blocks
	# and there x pos are always the same
	var wallNodes = wallTop.get_children()
	if (wallNodes.empty()):
		return false
	var center = wallNodes.size() / 2 - 1
	var pos = wallNodes[center].get_pos().x + blockSize.x / 2.0
	if player.get_pos().x > pos:
		return true
	return false