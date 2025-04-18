extends CharacterBody2D

const SPEED = 130.0 
const GRAVITY = -600.0 # Simulated gravity pulling the player down

@onready var animated_sprite = $AnimatedSprite2D
@onready var hurtBox = $hurtBox

@export var inventory: Inventory

var last_direction = "idle_down"  # Default idle direction

# Add a variable to track if the player is near trash/recycling bins
var near_bin = null
var current_trash_type = null # Track what trash is currently selected in inventory
var isHurt: bool = false

func _physics_process(delta: float) -> void:
	# Get movement input
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
	# Move the player
	velocity = direction * SPEED
	move_and_slide()
	
	if direction == Vector2.ZERO:
		# If player is not moving, switch to idle animation based on last direction
		animated_sprite.play(last_direction)
	else:
		# Determine movement direction and play corresponding animation
		if abs(direction.x) > abs(direction.y): # Prioritize horizontal movement
			if direction.x > 0:
				animated_sprite.play("walk_right")
				last_direction = "idle_right"
			else:
				animated_sprite.play("walk_left")
				last_direction = "idle_left"
		else:
			if direction.y > 0:
				animated_sprite.play("walk_down")
				last_direction = "idle_down"
			else:
				animated_sprite.play("walk_up")
				last_direction = "idle_up"
		
func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect()

func player():
	pass
