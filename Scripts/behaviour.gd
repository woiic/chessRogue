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
			#for y in range(1, boardRef.size.x -1): tenia esto y no  recuerdo por q
			for y in range(1, boardRef.size.y):
				var move = inPiece.boardPos + Vector2i(0, -1*y)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
		PieceType.KNIGHT:
			# podrías hacer esta parte con un vector, para q se pueda ajustar
			# para varias distancias
			return
		PieceType.BISHOP:
			var minSide = min(boardRef.size.x, boardRef.size.y)
			for x in range(1, minSide):
				var move = inPiece.boardPos + Vector2i(x , x)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			for x in range(1, minSide):
				var move = inPiece.boardPos + Vector2i(x , -x)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			for x in range(1, minSide):
				var move = inPiece.boardPos + Vector2i(-x , -x)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			for x in range(1, minSide):
				var move = inPiece.boardPos + Vector2i(-x , x)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			return movesArr
		PieceType.QUEEN:
			# straight
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
			for y in range(1, boardRef.size.y):
				var move = inPiece.boardPos + Vector2i(0, -1*y)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break 
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break 
			# diagonal
			var minSide = min(boardRef.size.x, boardRef.size.y)
			for x in range(1, minSide):
				var move = inPiece.boardPos + Vector2i(x , x)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			for x in range(1, minSide):
				var move = inPiece.boardPos + Vector2i(x , -x)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			for x in range(1, minSide):
				var move = inPiece.boardPos + Vector2i(-x , -x)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			for x in range(1, minSide):
				var move = inPiece.boardPos + Vector2i(-x , x)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						break
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
						break
			return movesArr
		PieceType.KING:
			for x in 8:
				var angulo = x*(PI/4.0)
				var dx = round(cos(angulo))
				var dy = round(sin(angulo))
				var move = inPiece.boardPos + Vector2i(dx , dy)
				#print(move)
				match boardRef.verifyMove(inPiece, move):
					MoveResult.STOP:
						continue
					MoveResult.MOVE:
						movesArr.append(move)
					MoveResult.CAPTURE:
						movesArr.append(move)
					_:
						continue
			return movesArr
	return movesArr

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
