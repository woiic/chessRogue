extends Node2D


#const TILE = preload("uid://bcf8rvvdkf3y5") # "res://Scenes/tile.tscn"
@onready var camera_2d: Camera2D = $Camera2D

@export var size: Vector2i = Vector2i()
@export var tile1: Variant
@export var tile2: Variant

var boardTiles: Array[Array] = []

func _init() -> void:
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in size.x:
		var newArr = []
		newArr.resize(size.y)
		newArr.fill(null)
		boardTiles.append(newArr)
		for y in size.y:
			var tile
			if (x + y) %2 ==0:
				tile = tile1.instantiate()
			else:
				tile = tile2.instantiate()
			tile.position = Vector2(x*tile.size, y*tile.size)
			boardTiles[x][y] = tile
			add_child(tile)
	camera_2d.position = Vector2(size.x*16, size.y*16)
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
