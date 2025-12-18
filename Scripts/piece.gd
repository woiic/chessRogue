extends Node2D
class_name Piece

enum Teams {
	BLACK=-1,
	NONE=0,
	WHITE=1
}

var team: Teams = Teams.WHITE
@export var pieceType: Behaviour.PieceType = Behaviour.PieceType.PAWN

var moves: Array[Vector2i] = []
var bHasMoved: bool = false
var boardPos: Vector2i = Vector2i()
var targetPosition: Vector2 = Vector2()
var bSelected: bool = false
var boardRef: Board
const moveSpeed = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setPosition(newPosition: Vector2i) -> void:
	boardPos = newPosition
	targetPosition = boardPos * 32
	if (!bHasMoved):
		position = targetPosition

func _physics_process(delta: float) -> void:
	if bSelected:
		var movement = get_global_mouse_position() - position
		var direction = movement.normalized()
		var maxMovement = direction * moveSpeed * delta
		position = position + maxMovement.abs().min(movement.abs()) * direction.sign()
	elif !bSelected and !position.is_equal_approx(targetPosition):
		var movement: Vector2 = targetPosition - position
		var direction: Vector2 = movement.normalized()
		var maxMovement: Vector2 = direction * moveSpeed * delta
		position = position + maxMovement.abs().min(movement.abs()) * direction.sign()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			bSelected = true
			print("Selected")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and bSelected and event.is_released():
			bSelected = false
			var mousePos: Vector2i = Vector2i(get_global_mouse_position()) + Vector2i(16, 16)
			var boardSize: Vector2i = boardRef.size
			# TODO: Handle better
			if (mousePos.x >= 0 and mousePos.y >= 0 and mousePos.x < (boardSize.x * 32) and mousePos.y < (boardSize.y * 32)):
				var tilePos: Vector2i = mousePos / 32
				boardRef.movePiece(self, tilePos)
			print("UnSelected")
