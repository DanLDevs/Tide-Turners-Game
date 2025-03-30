extends Panel

@onready var item_display: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

var slot_size: Vector2 = Vector2(64, 64)  # You can adjust this to match your slot size

func update(slot: InvSlot):
	if !slot.item:
		item_display.visible = false
		amount_text.visible = false
	else:
		item_display.visible = true
		item_display.texture = slot.item.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)
		
		# Scale the sprite to fit the slot sizse
		#item_display.scale = slot_size / item_display.texture.get_size()
		#
		# Center the sprite inside the slot
		#item_display.position = (slot_size - item_display.texture.get_size() * item_display.scale) / 2
