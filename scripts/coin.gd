extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		EventBus.coin_collected.emit(1)
		hide_from_player()

func hide_from_player():
	$Area2D.set_deferred("monitoring", false)
	visible = false
