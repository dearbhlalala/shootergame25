extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_scene.tscn")
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
