extends Control

@onready var label = $Background/Control/MessageLabel
var tween: Tween
var current_points: int = 0 # Track the current points for feedback

func _ready():
	self.visible = false

func show_feedback(increment: int, custom_message: String = ""):
	# Increment points and update the message
	current_points += increment
	
	# Use custom message if provided; otherwise, build a default message
	var message = custom_message if custom_message != "" else "+" + str(current_points) + (" point" if current_points == 1 else " points")
	if message != "":
		label.text = message
	else:
		label.text = str(current_points) + " points"
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
	self.visible = false
	current_points = 0
