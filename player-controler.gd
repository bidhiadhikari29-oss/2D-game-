extends CharacterBody2D


@export var speed = 10.0
@export var Jump_power = 20.0


var speed_multiplier = 30.0
var direction = 0
var jump_multiplier = -30.0


func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Horizontal movement
	direction = Input.get_axis("move-left", "move-right ")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)


	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = Jump_power * jump_multiplier

	# Move with collisions
	move_and_slide()

	# Animations
	if direction != 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		$AnimatedSprite2D.play("idle")
