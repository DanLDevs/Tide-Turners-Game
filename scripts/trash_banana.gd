extends Node2D

var state = "banana" # no banana, banana
var player_in_area = false

#@export var item: InvItem
var player = null

func _process(delta: float) -> void:
	if state == "no banana":
		$AnimatedSprite2D.visible = false
	if state == "banana":
		$AnimatedSprite2D.visible = true   # Show the sprite
		$AnimatedSprite2D.play("banana")
		if player_in_area and Input.is_action_just_pressed("e"):
			print("+1 Banana")
			#player.collect(item)
			state = "no banana"
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		
