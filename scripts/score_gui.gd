extends Control

@onready var score_label = $Score/Label

var score: int = 0
func add_score(amount: int):
	score += amount
	update_display()
	
func subtract_score(amount: int):
	score = max(score - amount, 0)
	update_display()
	
func update_display():
	score_label.text = "Score: %d" % score
