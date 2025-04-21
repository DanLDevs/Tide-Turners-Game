extends Resource

class_name Inventory

signal updated
signal inventory_full(item: InventoryItem)

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem) -> bool:
	var total_of_type = 0
	for slot in slots:
		if slot.item == item:
			total_of_type += slot.amount
			
	# If 5 or more, don't allow inserting
	if total_of_type >= 5:
		print("You can't carry more than 5 of this item.")
		inventory_full.emit(item)
		return false
		
	# Proceed with original stacking logic
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
			
	updated.emit()
	return true
	
func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	
	remove_at_index(index)
	
func remove_at_index(index: int) -> void:
	slots[index] = InventorySlot.new()
	updated.emit()

func insertSlot(index: int, inventorySlot: InventorySlot):
	slots[index] = inventorySlot
	updated.emit()

func use_item_at_index(index: int) -> void:
	if index < 0 || index >= slots.size() || !slots[index].item: return
	
	var slot = slots[index]
	
	if slot.amount > 1:
		slot.amount -= 1
		updated.emit()
		return
	
	remove_at_index(index)
