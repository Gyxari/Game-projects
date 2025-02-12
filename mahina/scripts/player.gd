extends CharacterBody2D
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@export var player_id = 1
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump_%s" % [player_id]) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		# Attack input ei vielä toimi
	if Input.is_action_just_pressed("attack_%" % [player_id]):
		animated_sprite.play("attack")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	var direction := Input.get_axis("move_left_%s" % [player_id], "move_right_%s" % [player_id])
	
	#Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
