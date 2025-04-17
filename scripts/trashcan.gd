extends Area2D

signal trash_dropped_correctly

func _on_body_entered(body):
	if body.is_in_group("trash"): # Ensure all trash items are in the "trash" group
		if body.has_method("get_trash_type") and body.trash_type == "banana": # Only accept non-recyclable trash (ensure body has trash_type)
			emit_signal("trash_dropped_correctly")
			body.queue_free() # Remove the trash item after correct sorting
			print("Trash correctly sorted into trash bin!")
		else:
			print("Incorrect sorting!") # Provide feedback for incorrect sorting


func _on_inventory_gui_closed() -> void:
	pass # Replace with function body.
