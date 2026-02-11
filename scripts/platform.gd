extends AnimatableBody2D

@export var curve: Curve

@export var left_offset: float = -10
@export var right_offset: float = 10
@export var speed: float = .1

var direction: bool = true
var pos: float = .5
var starting_pos: Vector2 = Vector2(0, 0)

func _ready() -> void:
	starting_pos.x = position.x
	starting_pos.y = position.y

func _process(delta: float) -> void:
	if direction:
		pos += speed * delta
	else:
		pos -= speed * delta
	
	if curve.sample(pos) == 1:
		direction = false
	elif curve.sample(pos) == 0:
		direction = true
		
	print(curve.sample(pos))
	global_position.x = (abs(right_offset) + abs(left_offset)) * curve.sample(pos) + starting_pos.x + left_offset
