extends Node2D

func _ready():
	var music_player = $MusicPlayer
	var stream = music_player.stream
	if stream is AudioStream:
		stream.loop = true
	music_player.play()


func _on_inventory_gui_closed() -> void:
	get_tree().paused = false


func _on_inventory_gui_opened() -> void:
	get_tree().paused = true
