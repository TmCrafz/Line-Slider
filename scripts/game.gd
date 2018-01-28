extends Node2D

var screenSize
var blockSize
var blockColor

var wallTop
var wallBottom
var player

onready var labelFps = get_node("Interface/Label_fps")

func _ready():
	screenSize = get_viewport().get_rect().size
	player = get_node("Player")
	blockSize = Vector2(120, 120)
	set_process(true)
	set_fixed_process(true)
	
func _process(delta):
	labelFps.set_text(str(OS.get_frames_per_second()))
	pass

func _fixed_process(delta):
	updateCamera()
	pass

func updateCamera():
#	print("updateCamera")
	var canvasTransform = get_viewport().get_canvas_transform()
	# The movement is inverted, like its like sliding a paper under a camera when modifying canvas transform 
	canvasTransform[2].x = -player.get_pos().x + screenSize.x / 2.0
	get_viewport().set_canvas_transform(canvasTransform)
	pass