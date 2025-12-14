extends Node2D
class_name Piece

enum Teams{
	BLACK=-1,
	NONE=0,
	WHITE=1
	}

var team: Teams = Teams.WHITE
@export var pieceType: Behaviour.PieceType = Behaviour.PieceType.PAWN

var moves: Array[Vector2i] = []
var bHasMoved: bool = false
var boardPos: Vector2i = Vector2i()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
