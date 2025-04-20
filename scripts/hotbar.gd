extends Panel

@onready var inventory: Inventory = preload("res://inventory/playerInventory.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $Selector
@onready var score_gui = $"../ScoreGui"
@onready var feedback_gui = $"../FeedbackGui"

var currently_selected: int = 0
var near_bin: Area2D = null # For trash/recycling

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	inventory.updated.connect(update)

func update() -> void:
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)
		
func move_selector() -> void:
	currently_selected = (currently_selected + 1) % slots.size()
	selector.global_position = slots[currently_selected].global_position

func _unhandled_input(event) -> void:
	if event.is_action_pressed("use_item"):
		#inventory.use_item_at_index(currently_selected)
		var item = inventory.slots[currently_selected].item
		if item and near_bin and item.trash_type == near_bin.bin_type:
			inventory.use_item_at_index(currently_selected)
			score_gui.add_score(10) # Correct bin
			feedback_gui.show_feedback(10, "+10 points! Correct bin!")
		else:
			score_gui.subtract_score(5)
			feedback_gui.show_feedback(-5, "-5 points! Wrong bin!")
	if event.is_action_pressed("move_selector"):
		move_selector()
