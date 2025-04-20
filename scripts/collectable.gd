extends Area2D

@export var itemRes: InventoryItem

func collect(inventory: Inventory, score_gui: Node):
	var success = inventory.insert(itemRes)
	if success:
		score_gui.add_score(1)
		queue_free()
	
