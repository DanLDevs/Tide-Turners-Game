extends Control

@onready var label = $Control/MessageLabel
var tween: Tween

func show_feedback(message: String):
	label.text = message
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
	tween.tween_callback(func(): self.visible = false)
