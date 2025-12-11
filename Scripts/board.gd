extends Node2D


#const TILE = preload("uid://bcf8rvvdkf3y5") # "res://Scenes/tile.tscn"
@onready var camera_2d: Camera2D = $Camera2D

@export var size: Vector2i = Vector2i()
@export var tile1: Variant
@export var tile2: Variant
const PAWN = preload("uid://c4pwaw4godgid")

var boardTiles: Array[Array] = []
var boardPieces: Array[Array] = []

func _init() -> void:
	return

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
	var piece
	piece = PAWN.instantiate()
	piece.pieceType = Behaviour.PieceType.ROOK
	piece.team = Piece.Teams.WHITE
	piece.position = Vector2(2*32, 3*32)
	piece.boardPos = Vector2i(2,3)
	boardPieces[2][3] = piece
	add_child(piece)
	
	var piece2
	piece2 = PAWN.instantiate()
	piece2.pieceType = Behaviour.PieceType.ROOK
	piece2.team = Piece.Teams.WHITE
	piece2.position = Vector2(2*32, 5*32)
	piece2.boardPos = Vector2i(2,5)
	boardPieces[2][5] = piece2
	add_child(piece2)
	#boardTiles[2][5].setPieces(piece2) # add child to tile
	
	var moves = Behaviour.getPosibleMoves(piece,self)
	print(moves)
	return

func verifyMove(inPiece: Piece, move: Vector2i) -> Behaviour.MoveResult:
	var pieceTeam = inPiece.team
	# out of bounds
	if size.x <= move.x or size.y <= move.y or move.x < 0 or move.y < 0:
		return Behaviour.MoveResult.STOP
	var otherPiece = boardPieces[move.x][move.y]
	if !otherPiece: # null
		return Behaviour.MoveResult.MOVE
	if otherPiece.team != pieceTeam:
		return Behaviour.MoveResult.CAPTURE
	return Behaviour.MoveResult.STOP
