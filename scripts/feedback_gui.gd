extends Control

@onready var label = $Background/Control/MessageLabel
var tween: Tween
var current_points: int = 0 # Track the current points for feedback

func _ready():
	self.visible = false
	#print("Feedback GUI initialized.")
	var player = get_node("../../Player")
	var inventory = player.inventory
	inventory.inventory_full.connect(_on_inventory_full)

func show_feedback(custom_message: String = ""):
	# Use custom message if provided; otherwise, build a default message
	var message = custom_message if custom_message != "" else str(current_points) + (" point" if abs(current_points) == 1 else " points")
	label.text = message
	
	print("Feedback message set to: ", message) # Debug print
		
	self.visible = true
	self.modulate.a = 1.0 # Reset alpha to fully visible
	
	# Kill previous tween if it exists and is still running
	if tween and tween.is_running():
		tween.kill() # If a previous tween is running
		
	# Create a new tween
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.2) # fade in
	tween.tween_interval(1.5)
	tween.tween_property(self, "modulate:a", 0.0, 0.5) # Fade out
	
	tween.tween_callback(Callable(self, "_on_tween_complete"))
	
func _on_tween_complete():
	#print("Tween complete, resetting points") # Debug print
	self.visible = false
	current_points = 0
	
func _on_inventory_full(item: InventoryItem):
	var item_name = item.name if item.name else "this item"
	show_feedback("Max " + item.name + " reached.")
