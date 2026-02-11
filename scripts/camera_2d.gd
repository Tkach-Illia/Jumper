extends Camera2D

@export var player: CharacterBody2D
@export var speed: float = 100.0
@export var dead_zone_radius: float = 100.0
@export var vert_offset: float = 300.0

func _process(delta: float) -> void:
	var pos_diif: float = global_position.y - player.global_position.y
	if abs(pos_diif) > dead_zone_radius and pos_diif > 0:
		global_position.y -= speed * delta * pos_diif / abs(pos_diif)
		
