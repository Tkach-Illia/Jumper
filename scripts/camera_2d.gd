extends Camera2D

# Вузол гравця, за яким слідкуємо
@export var target: NodePath
# Швидкість згладжування (чим більше, тим швидше каamera "доганяє" гравця)
@export var smoothing_speed: float = 5.0

var _target_node: Node2D = null

func _ready():
	if target:
		_target_node = get_node(target)
	else:
		# Якщо target не вказано, спробуємо знайти гравця за іменем
		_target_node = get_tree().get_first_node_in_group("player")  # не забудьте додати гравця до групи "player"

func _process(delta):
	if _target_node:
		# Плавне переміщення камери до цільової позиції
		var target_pos = _target_node.global_position
		global_position = global_position.lerp(target_pos, smoothing_speed * delta)
