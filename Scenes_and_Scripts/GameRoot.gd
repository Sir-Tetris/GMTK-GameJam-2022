extends Node2D


<<<<<<< Updated upstream
export(PackedScene) var levelScene


	
func _ready():
	var lvl = levelScene.instance()
	add_child(lvl)
=======
var levelScene = preload("res://Scenes/Level.tscn")

var level
	
func _ready():
	startLevel()


func _on_Button_pressed():
	remove_child(level)
	startLevel()


func startLevel() -> void:
	$HUDLayer/CenterContainer/PanelContainer.hide()
	level = levelScene.instance()
	add_child(level)
	level.get_node("Player").connect("onDie", $HUDLayer/CenterContainer/PanelContainer, "show")
>>>>>>> Stashed changes
