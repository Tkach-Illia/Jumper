extends Node2D

@export var coin_label: Label
var coins_collected: int = 0

var hidden_platforms: Array[Platform] = []
var hidden_coins: Array[Coin] = []
var screen_size: Vector2i
func _ready() -> void:
	screen_size = DisplayServer.window_get_size()
	EventBus.coin_collected.connect(_handle_coin_collection)
	EventBus.platform_is_hidden.connect(_handle_hidden_platform)
	EventBus.coin_is_hidden.connect(_handle_hidden_coin)
	
func _handle_coin_collection(number: int):
	coins_collected+= number
	coin_label.set_text(str(coins_collected))

func _handle_hidden_platform(platform: Platform):
	print(platform)
	hidden_platforms.append(platform)
	generate_level()
	
func _handle_hidden_coin(coin: Coin):
	hidden_coins.append(coin)

func generate_level():
	for hidden_platform in hidden_platforms:
		hidden_platform.mode = [Enums.Platform_mods.Still, Enums.Platform_mods.Moving_hor].pick_random()
		#var coords = Vector2(int(screen_size.x * randf() - screen_size.x/2)/2, int(hidden_platform.global_position.y -= screen_size.y*0.1))
		#print(coords.y)
		#hidden_platform.reset_position(coords)
		hidden_platform.global_position.y -= 100
		print("GLOBAL:", hidden_platform.global_position)
	hidden_platforms = []
