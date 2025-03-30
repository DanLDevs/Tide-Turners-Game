extends Node2D

var state = "bottle" # no bottle, bottle
var player_in_area = false

@export var item: InvItem
var player = null

func _process(delta: float) -> void:
	if state == "no bottle":
		$AnimatedSprite2D.visible = false
	if state == "bottle":
		$AnimatedSprite2D.visible = true   # Show the sprite
		$AnimatedSprite2D.play("bottle")
		if player_in_area and Input.is_action_just_pressed("e"):
			print("+1 Bottle")
			player.collect(item)
			state = "no bottle"
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		
