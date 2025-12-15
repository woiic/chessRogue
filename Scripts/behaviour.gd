extends Node
#class_name PieceBehaviour

enum MoveResult{STOP=0, MOVE=1, CAPTURE=2}

enum PieceType{PAWN=0, ROOK, KNIGHT, BISHOP, QUEEN, KING}

func getPosibleMoves(inPiece: Piece, boardRef: Board):
	var movesArr: Array[Vector2i] = []
	match inPiece.pieceType:
		PieceType.PAWN:
			# get the forward direction in the board depending on your side
			var forward: Vector2i = Vector2i(0, 1) if inPiece.team == Piece.Teams.BLACK else Vector2i(0, -1)
			# Simplest move, 1 block forward (not counting capture)
			if boardRef.verifyMove(inPiece, inPiece.boardPos + forward) == MoveResult.MOVE:
				movesArr.append(inPiece.boardPos + forward)
				# In the starting case where the piece hasn't moved you can move twice in the
				# forward direction (again not counting capture)
				if not inPiece.bHasMoved and boardRef.verifyMove(inPiece, inPiece.boardPos + 2*forward) == MoveResult.MOVE:
					movesArr.append(inPiece.boardPos + 2*forward)
			# capture in forward diagonal in both directions
			if boardRef.verifyMove(inPiece, inPiece.boardPos + forward + Vector2i(1, 0)) == MoveResult.CAPTURE:
				movesArr.append(inPiece.boardPos + forward + Vector2i(1, 0))
			if boardRef.verifyMove(inPiece, inPiece.boardPos + forward + Vector2i(-1, 0)) == MoveResult.CAPTURE:
				movesArr.append(inPiece.boardPos + forward + Vector2i(-1, 0))
			return movesArr

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
			const possibleMoves: Array[Vector2i] = [
				Vector2i(2, 1),
				Vector2i(2, -1),
				Vector2i(-2, 1),
				Vector2i(-2, -1),
				Vector2i(1, 2),
				Vector2i(1, -2),
				Vector2i(-1, 2),
				Vector2i(-1, -2)
			]
			for move in possibleMoves:
				if boardRef.verifyMove(inPiece, inPiece.boardPos + move) != MoveResult.STOP:
					movesArr.append(inPiece.boardPos + move)
			return movesArr

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
