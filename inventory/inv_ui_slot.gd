extends Panel

@onready var paper_visual: AnimatedSprite2D = $trash_paper
@onready var banana_visual: AnimatedSprite2D = $trash_banana
@onready var bottle_visual: AnimatedSprite2D = $trash_bottle

func update(item: InvItem):
	if !item:
		paper_visual.visible = false
	else:
		paper_visual.visible = true
		paper_visual.texture = item.texture
