extends HBoxContainer

@onready var inventory: Inventory = preload("res://inventory/playerInventory.tres")
@onready var slots: Array = get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	inventory.updated.connect(update)

func update() -> void:
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)
