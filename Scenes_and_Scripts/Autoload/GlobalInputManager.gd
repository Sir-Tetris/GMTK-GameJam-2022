extends Node



func _input(event):
	if event.is_action("quit"):
		get_tree().quit()
