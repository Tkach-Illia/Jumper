extends Node2D

@export var coin_label: Label
var coins_collected: int = 0

func _ready() -> void:
	EventBus.coin_collected.connect(_handle_coin_collection)
	
func _handle_coin_collection(number: int):
	coins_collected+= number
	coin_label.set_text(str(coins_collected))
