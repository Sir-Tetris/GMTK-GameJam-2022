extends GameObject
class_name Actor



#var ACCELERATION = 300.0
#var _currentSpeed:float = 0.0
#var _currentMaxSpeed:float = 10000
#
#
#func orientate(newOrientation:Vector2) -> void:
#	$SpriteRoot.rotation = newOrientation.angle()
#
#
## can optionaly give a newMaxSpeed to call setMaxSpeed
#func resetSpeed(newMaxSpeed:float = -1) -> void:
#	_currentSpeed = 0
#
#	if newMaxSpeed >= 0:
#		setNewMaxSpeed(newMaxSpeed)
#
#func setNewMaxSpeed(new:float) -> void:
#	if new < 0:
#		push_error("New max speed should be a positive value")
#		return
#	_currentMaxSpeed = new
#	if _currentSpeed > new:
#		_currentSpeed = new

