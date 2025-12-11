extends Node
#class_name PieceBehaviour

enum MoveResult{STOP=0, MOVE=1, CAPTURE=2}

enum PieceType{PAWN=0, ROOK, KNIGHT, BISHOP, QUEEN, KING}

func getPosibleMoves(inPiece, boardRef):
	var movesArr = []
	match inPiece.pieceType:
		PieceType.PAWN:
			#if !inPiece.bHasMoved:
			#	movesArr.append(inPiece.boardPos + Vector2i(0, 2*inPiece.type))
			#movesArr.append(inPiece.boardPos + Vector2i(0, 1*inPiece.type))
			#capturesArr.append(inPiece.boardPos + Vector2i(1, 1*inPiece.type))
			#capturesArr.append(inPiece.boardPos + Vector2i(-1, 1*inPiece.type))
			#boardRef.verifyMoves()
			return
		PieceType.ROOK:
			for x in range(1, boardRef.size.x):
				var move = inPiece.boardPos + Vector2i(1*x , 0)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			for x in range(1, boardRef.size.x):
				var move = inPiece.boardPos + Vector2i(-1*x , 0)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			for y in range(1, boardRef.size.y):
				var move = inPiece.boardPos + Vector2i(0, 1*y)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			for y in range(1, boardRef.size.x -1):
				var move = inPiece.boardPos + Vector2i(0, -1*y)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
	return movesArr

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
