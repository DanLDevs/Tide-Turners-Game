extends Area2D

@export var itemRes: InventoryItem

func collect(inventory: Inventory):
	var success = inventory.insert(itemRes)
	if success:
		queue_free()
	
