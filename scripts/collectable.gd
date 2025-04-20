extends Area2D

@export var itemRes: InventoryItem

func collect(inventory: Inventory, score_gui: Node):
	var success = inventory.insert(itemRes)
	if success:
		var point_value = 1
		var point_label = "point" if point_value == 1 else "points"
		var message = "+" + str(point_value) + " " + point_label
		
		# Find FeedbackGui in the main scene tree
		var feedback_gui = get_tree().root.get_node("Game/CanvasLayer/FeedbackGui")
		
		# Show feedback if FeedbackGui exists
		if feedback_gui:
			feedback_gui.show_feedback(1)
		else:
			print("Error: FeedbackGui is not found!")
		score_gui.add_score(point_value)
		queue_free()
	
