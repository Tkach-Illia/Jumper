extends CharacterBody2D

var gravity : float = 200.0
var speed : float = 200.0
var bounce_force : float = 300.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = -bounce_force 
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
	else:
		velocity.x = 0
		
	move_and_slide()
