extends CharacterBody2D

# Експортовані змінні для налаштування в інспекторі
@export var speed: float = 300.0
@export var jump_velocity: float = -400.0  # від'ємне значення, бо вісь Y направлена вниз
@export var sprite: Sprite2D

# Гравітація, яка буде застосовуватись до персонажа
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var spears_left := 3
var direction_facing = 0

func _physics_process(delta):
	# Додаємо гравітацію, якщо персонаж не на підлозі
	if not is_on_floor():
		velocity.y += gravity * delta

	# Обробка стрибка
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	if Input.is_action_just_pressed("shoot") and spears_left>0:
		shoot_spear(direction_facing)
		spears_left -= 1
	# Отримуємо напрямок руху: вліво/вправо (вісь X)
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		direction_facing = direction
		velocity.x = direction * speed
	else:
		# Поступове зменшення швидкості, щоб рух був плавним
		velocity.x = move_toward(velocity.x, 0, speed)
	update_sprite()
	move_and_slide()

func update_sprite():
	if direction_facing == 0:
		sprite.texture = preload("res://resources/player/player.png")
	else:
		sprite.texture = preload("res://resources/player/player2.png")
		if direction_facing < 0:
			sprite.flip_h = 1
		else:
			sprite.flip_h = 0
			
func shoot_spear(direction_facing):
	var spear: Spear = preload("res://scenes/spear.tscn").instantiate()
	get_parent().add_child(spear)
	spear.shoot(direction_facing,get_global_position())
