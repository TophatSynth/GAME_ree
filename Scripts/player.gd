extends CharacterBody2D


@export var speed : float = 300.0
@export var jump_velocity : float = -400.0

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interactable_finder : Area2D = $Marker2D/InteractableFinder

# Get the gravity from the project settings to be synced with RigidBody nodes.
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float = 0


func _physics_process(delta):
	if GameState.is_dialogue_running == false:
		if Input.is_action_just_pressed("interact"):
			var actionables = interactable_finder.get_overlapping_areas()
			if actionables.size() > 0:
				actionables[0].start()
			
		# Add the gravity.
		if not is_on_floor():
			velocity.y += GRAVITY * delta

		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = 0
		
		

		move_and_slide()
		play_animation()
		
	

func play_animation():
	if direction > 0: 
		animation_player.play("idle_right")
	elif direction < 0: 
		animation_player.play("idle_left")
