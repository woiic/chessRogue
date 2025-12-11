extends Node2D
class_name Tile

@onready var tile_sprite: Sprite2D = $TileSprite
@export var texture: Texture2D = Texture2D.new()
@export var size:int = 32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_sprite.texture = texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
