extends Area2D

@export var itemRes: InventoryItem

func collect(inventory: Inventory, score_gui: Node):
	var success = inventory.insert(itemRes)
	if success:
		# Find FeedbackGui in the main scene tree
		var feedback_gui = get_tree().root.get_node("Game/CanvasLayer/FeedbackGui")
		
		var point_value = 1
		var point_label = "point" if point_value == 1 else "points"
		var message = "Picked up trash! +" + str(point_value) + " " + point_label

		# Show feedback if FeedbackGui exists
		if feedback_gui:
			feedback_gui.current_points += point_value
			feedback_gui.show_feedback(message)
		else:
			print("Error: FeedbackGui is not found!")
		score_gui.add_score(point_value)
		queue_free()
	
