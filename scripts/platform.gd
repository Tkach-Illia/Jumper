extends AnimatableBody2D
class_name Platform
@export var curve: Curve

@export var left_offset: float = -10
@export var right_offset: float = 10
@export var speed: float = .1
@export var mode: Enums.Platform_mods = Enums.Platform_mods.Still
var direction: bool = true
var pos: float = .5
var starting_pos: Vector2 = Vector2(0, 0)

func _ready() -> void:
	starting_pos.x = position.x
	starting_pos.y = position.y

func _process(delta: float) -> void:
	if mode == Enums.Platform_mods.Moving_hor:
		if direction:
			pos += speed * delta
		else:
			pos -= speed * delta
		
		if curve.sample(pos) == 1:
			direction = false
		elif curve.sample(pos) == 0:
			direction = true
			
		global_position.x = (abs(right_offset) + abs(left_offset)) * curve.sample(pos) + starting_pos.x + left_offset

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	EventBus.platform_is_hidden.emit(self)

func reset_position(new_pos: Vector2):
	global_position = new_pos
	#starting_pos = new_pos
	pos = 0.5
	direction = true
