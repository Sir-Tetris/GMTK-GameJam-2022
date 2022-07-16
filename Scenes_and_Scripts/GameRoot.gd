extends Node2D


export(PackedScene) var levelScene


	
func _ready():
	var lvl = levelScene.instance()
	add_child(lvl)
