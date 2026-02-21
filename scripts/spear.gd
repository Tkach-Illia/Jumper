extends CharacterBody2D
class_name Spear

@export var sprite: Sprite2D

var direction_facing: int= -1
var speed: float = 400.0
var is_shooted: bool = false

func _process(delta: float) -> void:
	if is_shooted:
		var collision = move_and_collide(Vector2(direction_facing * speed * delta, 0))
		if collision:
			is_shooted = false
			set_physics_process(false)
			
func update_sprite():
	sprite.texture = preload("res://resources/player/spear.png")
	sprite.flip_h = direction_facing > 0

func shoot(_direction_facing: int, coords: Vector2):
	direction_facing = _direction_facing
	update_sprite()
	set_global_position(coords)
	is_shooted = true
	set_physics_process(true)
