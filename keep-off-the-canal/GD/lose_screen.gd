extends Control



func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/game.tscn")


func _on_menu_button_2_pressed() -> void:
	get_tree().quit()


func _on_menu_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
