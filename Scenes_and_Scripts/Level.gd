extends Node2D




func _ready():
	$Boss.player = $Player
	$Boss.connect("onRoll", $Camera/AnimationPlayer, "play", ["Shake"])
	
	$Player.connect("positionUpdated", $Camera, "onPlayerPositionUpdated")
<<<<<<< Updated upstream
	$Player.connect("detachCamera", $Camera, "onDetachCamera")
	$Player.connect("attachCamera", $Camera, "onAttachCamera")
=======
#	$Player.connect("detachCamera", $Camera, "onDetachCamera")
#	$Player.connect("attachCamera", $Camera, "onAttachCamera")
	generatePathfindingData()

func generatePathfindingData() -> void:
	var cells = $FloorTiles.get_used_cells_by_id(0)
	
	for c in cells:
		Pathfinder.addTile(c)
>>>>>>> Stashed changes
