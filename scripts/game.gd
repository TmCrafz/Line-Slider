extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screenSize
var blockSize
var playerSize

var blockTop
var blockBottom
var player

func _ready():
	screenSize = get_viewport_rect().size
	blockSize = Vector2(screenSize.x, 120)
	var blockColor = Color(0.69, 0.09, 0.12)
	var blockPols = Vector2Array()
	blockPols.append(Vector2(0, 0))
	blockPols.append(Vector2(blockSize.x, 0))
	blockPols.append(Vector2(blockSize.x, blockSize.y))
	blockPols.append(Vector2(0, blockSize.y))

	blockTop = Polygon2D.new()
	blockTop.set_polygon(blockPols)
	blockTop.set_color(blockColor)
	add_child(blockTop);
	
	blockBottom = Polygon2D.new()
	blockBottom.set_polygon(blockPols);
	blockBottom.set_color(blockColor)
	blockBottom.set_pos(Vector2(0, screenSize.y - blockSize.y))
	add_child(blockBottom);
	
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
	add_child(player)
	
	pass
