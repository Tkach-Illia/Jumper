extends Node2D
class_name Coin

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		EventBus.coin_collected.emit(1)
		hide_from_player()

func hide_from_player():
	$Area2D.set_deferred("monitoring", false)
	visible = false

func show_player():
	$Area2D.set_deferred("monitoring", true)
	visible = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	EventBus.coin_is_hidden.emit(self)
