extends Node2D
class_name Board

@onready var camera_2d: Camera2D = $Camera2D

@export var size: Vector2i = Vector2i()
@export var tile1: Variant
@export var tile2: Variant

const PAWN = preload("uid://c4pwaw4godgid")
const KING = preload("uid://c8v1jxyhwqiq")
const KNIGHT = preload("uid://b1k0coyphnp77")
const ROOK = preload("uid://bo8ql20fas4xo")
const QUEEN = preload("uid://dvmmwtisqy5de")
const BISHOP = preload("uid://b0s78cny2bgin")

# add more when preloading the rest
const pieceObjectMap = {
	Behaviour.PieceType.PAWN: PAWN,
	Behaviour.PieceType.KING: KING,
	Behaviour.PieceType.KNIGHT: KNIGHT,
	Behaviour.PieceType.QUEEN: QUEEN,
	Behaviour.PieceType.ROOK: ROOK,
	Behaviour.PieceType.BISHOP: BISHOP
}

var boardTiles: Array[Array] = []
var boardPieces: Array[Array] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateBoard()
	generatePieces()
	return

func generateBoard():
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

func generatePieces():
	for x in size.x:
		var newArr = []
		newArr.resize(size.y)
		newArr.fill(null)
		boardPieces.append(newArr)
	var piece = instanciatePiece(Behaviour.PieceType.KNIGHT, Piece.Teams.WHITE, Vector2i(2, 3))
	var _piece2 = instanciatePiece(Behaviour.PieceType.KING, Piece.Teams.WHITE, Vector2i(0, 2))
	var _piece3 = instanciatePiece(Behaviour.PieceType.PAWN, Piece.Teams.BLACK, Vector2i(3, 2))
	var moves = Behaviour.getPosibleMoves(piece,self)
	print(moves)
	return

func verifyMove(inPiece: Piece, move: Vector2i) -> Behaviour.MoveResult:
	var pieceTeam = inPiece.team
	# out of bounds
	if size.x <= move.x or size.y <= move.y or move.x < 0 or move.y < 0:
		#print("stop")
		return Behaviour.MoveResult.STOP
	var otherPiece = boardPieces[move.x][move.y]
	if !otherPiece: # null
		#print("move")
		return Behaviour.MoveResult.MOVE
	if otherPiece.team != pieceTeam:
		#print("capture")
		return Behaviour.MoveResult.CAPTURE
	return Behaviour.MoveResult.STOP

func instanciatePiece(pieceType: Behaviour.PieceType, team: Piece.Teams, startingPosition: Vector2i) -> Piece:
	var pieceObject = pieceObjectMap[pieceType]
	var piece = pieceObject.instantiate()
	piece.team = team
	piece.position = startingPosition * 32
	piece.boardPos = startingPosition
	boardPieces[startingPosition.x][startingPosition.y] = piece
	add_child(piece)
	return piece
