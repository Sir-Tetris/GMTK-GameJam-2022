extends Camera2D


var bAttached:bool = true
var bReattaching:bool = false
var currentPosition:Vector2

const trackSpeed = 1000

func onPlayerPositionUpdated(pos:Vector2) -> void:
	currentPosition = pos
	
	if bAttached:
		position = pos
	
func onDetachCamera() -> void:
	bAttached = false
	
func onAttachCamera() -> void:
	bReattaching = true
	
func _process(delta):
	if bReattaching:
		var dist = currentPosition - position

		var moveDist = delta * trackSpeed

		if dist.length() <= moveDist:
			position = currentPosition
			bAttached = true
			bReattaching = false
		else:
			position = position + dist.normalized() * moveDist



