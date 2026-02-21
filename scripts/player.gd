extends CharacterBody2D

# Експортовані змінні для налаштування в інспекторі
@export var speed: float = 300.0
@export var jump_velocity: float = -400.0  # від'ємне значення, бо вісь Y направлена вниз

# Гравітація, яка буде застосовуватись до персонажа
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Додаємо гравітацію, якщо персонаж не на підлозі
	if not is_on_floor():
		velocity.y += gravity * delta

	# Обробка стрибка
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Отримуємо напрямок руху: вліво/вправо (вісь X)
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * speed
	else:
		# Поступове зменшення швидкості, щоб рух був плавним
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
