extends CharacterBody2D

const SPEED = 130.0 
const GRAVITY = -600.0 # Simulated gravity pulling the player down

@onready var animated_sprite = $AnimatedSprite2D
@onready var interaction_area = $Area2D
@onready var player = get_node("Player")

@export var max_inventory_size: int = 10
var inventory: Dictionary = {} # Dictionary to store collected trash

var last_direction = "idle_down"  # Default idle direction

# Add a variable to track if the player is near trash/recycling bins
var near_bin = null
var current_trash_type = null # Track what trash is currently selected in inventory

func _ready() -> void:
	print("Inventory system initialized!")
	add_to_group("player") # Add the player to the "player" group
	
	# Check if the player is inside the interaction area
	var overlapping_boddies = interaction_area.get_overlapping_bodies()
	
	for body in overlapping_boddies:
		if body == player:
			print("Player is in the interaction area")
			# Handle interaction logic here, e.g., collecting trash
		else:
			print("Something else is in the interaction area")

func collect_trash(trash_node, trash_type: String):
	print("Collecting trash...") # Debug print to ensure this method is being called
	var total_trash = get_total_trash()
	print("Total Trash: ", total_trash) # Debug print
	print("Max Inventory Size: ", max_inventory_size) # Debug print
	
	if total_trash < max_inventory_size:
		# Add to inventory
		if trash_type in inventory:
			print("Collecting trash:", trash_type) # Debug print
			inventory[trash_type] += 1
		else:
			inventory[trash_type] = 1
			
		# Update current trash type to the one just collected
		current_trash_type = trash_type
			
		print("Collected:", trash_type)
		print("Current Inventory:", inventory) # Debug: Show current inventory
		
		# Optional: You can use the trash to provide feedback, like playing a sound or animating
		trash_node.queue_free()
	else:
		print("Inventory full! Cannot pick up more trash.")
		# Optional: Provide feedback that inventory is full, such as a sound or UI alert
		
func get_total_trash() -> int:
	var count = 0
	for amount in inventory.values():
		count += amount
	print("Total trash in inventory:", count) # Debug print to verify the count
	return count

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
	
	# Handle interaction			
	if near_bin and Input.is_action_just_pressed("interact"):
		# Check if the player is near a bin and the trash type matches the bin type
		if near_bin.name == "RecyclingBin" and current_trash_type in ["bottle", "paper"]:
			# Correctly sort the trash into the recycling bin
			print("Trash correctly sorted into recycling bin!")
			inventory[current_trash_type] -= 1 # Remove from inventory
			if inventory[current_trash_type] <= 0:
				inventory.erase(current_trash_type) # Remove completely if 0
			print("Current inventory after sorting:", inventory) # Debug message
			near_bin = null # Reset after sorting
			
		elif near_bin.name == "TrashBin" and current_trash_type == "banana":
			# Correctly sort the trash into the trash bin
			print("Trash correctly sorted into trash bin!")
			inventory[current_trash_type] -= 1
			if inventory[current_trash_type] <= 0:
				inventory.erase(current_trash_type)
			print("Current Inventory after sorting:", inventory) # Debug messageaw
			near_bin = null
		else:
			print("Incorrect sorting! Please try again.")

# When the player collects trash (make sure this is being triggered)
func _on_body_entered(body):
	if body.is_in_group("trash"): # Assumming trash is in the "trash" group
		print("Player entered trash area")
		print("Collecting trash: ", body.name) # Debug print to confirm the trash is being collected
		collect_trash(body, body.name)
	elif body.is_in_group("bin"): # Checking if the player is near a bin
		print("Player entered bin area:", body.name)
		near_bin = body # Save the bin the player is near
		print("Now near bin:", near_bin.name)

# When the player exits an area (e.g., trash or bin area)
func _on_body_exited(body):
	print("Body exited: ", body.name) # Print body name when something exits the area
	if body == player: # Ensure it's the player exiting
		if body.is_in_group("bin"): # If the player exited a bin area
			print("Player exited a bin area!")
			near_bin = null # Set the near_bin to the bin the player entered
		else:
			print("Player exited a non-bin area.")
