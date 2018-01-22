extends Node2D

var screenSize
var blockSize
var playerSize

var blockTop
var blockBottom
var player

func _ready():
	screenSize = get_viewport_rect().size
	
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
	blockTop = Polygon2D.new()
	blockTop.set_polygon(blockPols)
	blockTop.set_color(blockColor)
	var staticBodyTop = StaticBody2D.new()
	var collisionPolygonTop = CollisionPolygon2D.new()
	collisionPolygonTop.set_polygon(blockPols)
	staticBodyTop.add_child(collisionPolygonTop)
	blockTop.add_child(staticBodyTop)
	add_child(blockTop);
	# Create bottom block
	blockBottom = Polygon2D.new()
	blockBottom.set_polygon(blockPols);
	blockBottom.set_color(blockColor)
	blockBottom.set_pos(Vector2(0, screenSize.y - blockSize.y))
	var staticBodyBottom = StaticBody2D.new()
	var collisionPolygonBottom = CollisionPolygon2D.new()
	collisionPolygonBottom.set_polygon(blockPols)
	staticBodyBottom.add_child(collisionPolygonBottom)
	blockBottom.add_child(staticBodyBottom)
	add_child(blockBottom);
	
	# Create player
	var playerColor = Color(0.10, 0.10, 0.44)
	playerSize = Vector2(80, 80)
	var playerPols = Vector2Array()
	playerPols.append(Vector2(-playerSize.x / 2.0, -playerSize.y / 2.0))
	playerPols.append(Vector2(playerSize.x / 2.0, -playerSize.y / 2.0))
	playerPols.append(Vector2(playerSize.x / 2.0, playerSize.y / 2.0))
	playerPols.append(Vector2(-playerSize.x / 2.0, playerSize.y / 2.0))
	player = Polygon2D.new()
	player.set_polygon(playerPols)
	player.set_color(playerColor)
	player.set_pos(Vector2(screenSize.x / 2.0, screenSize.y / 2.0))
	var staticBodyPlayer = StaticBody2D.new()
	var collisionPolygonPlayer = CollisionPolygon2D.new()
	collisionPolygonPlayer.set_polygon(playerPols)
	staticBodyPlayer.add_child(collisionPolygonPlayer)
	player.add_child(staticBodyPlayer)
	add_child(player)
	
	
	pass
