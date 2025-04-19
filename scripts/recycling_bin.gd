extends Area2D

#signal trash_dropped_correctly

@onready var bin_type = "recycling"

#func _on_body_entered(body):
	#if body.is_in_group("trash"): # Ensure all trash objects are in the "trash" group
		#if body.trash_type in ["bottle", "paper"]: # Only recyclable items
			#emit_signal("trash_dropped_correctly")
			#body.queue_free() # Remove the trash item
			#print("Trash correctly sorted into recycling bin!")
		#else:
			#print("Incorrect sorting!") # Can add feedback for incorrect sorting
