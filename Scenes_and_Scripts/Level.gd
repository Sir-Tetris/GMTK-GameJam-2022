extends Node2D




func _ready():
	$Boss.player = $Player
	$Boss.connect("onRoll", $Camera/AnimationPlayer, "play", ["Shake"])
	
	$Player.connect("positionUpdated", $Camera, "onPlayerPositionUpdated")
	$Player.connect("detachCamera", $Camera, "onDetachCamera")
	$Player.connect("attachCamera", $Camera, "onAttachCamera")
