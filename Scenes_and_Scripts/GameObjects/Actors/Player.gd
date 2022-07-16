extends Actor
class_name Player


<<<<<<< Updated upstream
=======
var stepSoundsList = [
	preload("res://Assets/Sounds/Footsteps/walk_01.wav"),
	preload("res://Assets/Sounds/Footsteps/walk_02.wav"),
	preload("res://Assets/Sounds/Footsteps/walk_03.wav"),
]


>>>>>>> Stashed changes
signal playerInteracting(player)

signal positionUpdated(position)
signal detachCamera()
signal attachCamera()

<<<<<<< Updated upstream
=======
signal onDie()

>>>>>>> Stashed changes
onready var previousOrientation:Vector2 = Vector2(1,0)
var rotationSpeed:float = 2 * PI / 0.85
const baseSpeed = 300

export(Curve) var rollingCurve

var bStartedRolling:bool = false
var bIsRolling:bool = false

var interactableList:Array = []
var closestInteractable

var forwardFacingAngle:float = PI / 4

# controls wether the mouse is used to orientate the character
var bMouseControlEnabled:bool = false




		
func _process(_delta):
	if bStartedRolling:
#		$AudioStreamPlayer2D.stream = load("res://Sound/swordSwipe1.wav")
#		$AudioStreamPlayer2D.play()
		bStartedRolling = false
	
	


func _input(event):
	if event is InputEventKey:
		bMouseControlEnabled = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventJoypadMotion or event is InputEventJoypadButton:
		bMouseControlEnabled = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#
#func _unhandled_input(event):		
#	if event.is_action("roll") and event.is_pressed():
#		if !bIsDashing and $DashingCooldown.is_stopped():
#			dash()
#	elif event.is_action("interact") and event.is_pressed():
#		emit_signal("playerInteracting")
#		$DashingCooldown.start()
		
#func roll() -> void:
#	$DashingDuration.start()
#	bStartedDashing = true
#	bIsDashing = true
#	dashingOrientation = $SpriteRoot.rotation
#	emit_signal("detachCamera")
#	$DashingSmoke.emitting = true
#	$DashingSmoke.rotation = $SpriteRoot.rotation
#	$MenaceRange.disableMenace()
#
#	for body in $SpriteRoot/SwordHitbox.get_overlapping_bodies():
#		if body is Enemy:
#			killEnemy(body)
			

<<<<<<< Updated upstream

func _physics_process(delta):
	var motion:Vector2

	var velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * baseSpeed
	
	var orientation:Vector2

	if bMouseControlEnabled:
		orientation = (get_global_mouse_position() - global_position ).normalized()
	else:
		orientation = Input.get_vector("orientate_left", "orientate_right", "orientate_up", "orientate_down")
=======
func stopMoving():
	$SpriteRoot/AnimatedSprite.playing = false
func startMoving():
	$SpriteRoot/AnimatedSprite.playing = true
	
func _physics_process(delta):
	$Label.text = str(Pathfinder.getTileFromPosition(position))
	var motion:Vector2

	var velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * baseSpeed
	if velocity.length() == 0:
		stopMoving()
	else:
		startMoving()
	
	var orientation:Vector2

#	if bMouseControlEnabled:
#		orientation = (get_global_mouse_position() - global_position ).normalized()
#	else:
#		orientation = Input.get_vector("orientate_left", "orientate_right", "orientate_up", "orientate_down")
>>>>>>> Stashed changes
		

#	var angleGap = abs(velocity.angle() - currentOrientation)
	var orientationSpeedMultiplier:float = 1.0
#	if angleGap > 3 * PI / 4:
#		orientationSpeedMultiplier = 0.5
#	elif angleGap > forwardFacingAngle:
#		orientationSpeedMultiplier = 0.75
#	motion = velocity * delta * orientationSpeedMultiplier



#	if bIsDashing:
	if false:
		pass
#		if $DashingDuration.time_left <= 0.15:
#			emit_signal("attachCamera")
#
#		var dashingSpeed = 4 * baseSpeed * dashingCurve.interpolate($DashingDuration.wait_time - $DashingDuration.time_left / $DashingDuration.wait_time)
#		motion = Vector2(cos(dashingOrientation), sin(dashingOrientation)) * delta * dashingSpeed
#		var collided = move_and_collide(motion)
#
#		if OS.is_window_focused():
#			Input.warp_mouse_position(get_viewport().get_mouse_position() + motion)
#	elif bIsSwinging:
#		if $SwingingTween.get_runtime() - $SwingingTween.tell() <= 0.15:
#			emit_signal("attachCamera")
		
	elif OS.is_window_focused():
#			move_and_collide(motion)
<<<<<<< Updated upstream
		move_and_slide(velocity)
=======
		var data = move_and_collide(velocity * delta)
		
		if data:
			if data.collider is Boss and data.collider.bIsAttacking:
				print("died")
				die()
>>>>>>> Stashed changes
#		p_position = position

		emit_signal("positionUpdated", position)

<<<<<<< Updated upstream
		if orientation.length() >= 0.3:
			rotateTowardGoal(orientation, delta)
#
#
		
	
=======
		if velocity.length() >= 0.3:
			rotateTowardGoal(velocity, delta)


func die():
	emit_signal("onDie")
	get_parent().remove_child(self)
	queue_free()
>>>>>>> Stashed changes


#func _on_DashingDuration_timeout():
#	stopDashing()

#func stopDashing():
#	if bIsDashing:
#		bIsDashing = false
#		$DashingDuration.stop()
#		$DashingCooldown.start()
#		$MenaceRange.recoverMenace($CollisionShape2D.shape.radius)
	

	






func _on_DashingCooldown_timeout():
	if is_network_master():
		$RecoverDash.emitting = true
		$AnimationPlayer.play("RecoverDash")
		
	

		
func setNewOrientation(newOrientation:Vector2) -> void:
	previousOrientation = newOrientation
	$SpriteRoot.rotation = newOrientation.angle()
	

func rotateTowardGoal(orientationGoal:Vector2, delta:float) -> void:
	var newOrientation:Vector2

	var orientationDiff:float = previousOrientation.angle_to(orientationGoal)

	if abs(orientationDiff) <= rotationSpeed * delta : #or bIsDashing:
		newOrientation = orientationGoal
	else:
		var clockWise = orientationDiff / abs(orientationDiff)
		var angle = rotationSpeed * delta  * clockWise + previousOrientation.angle()
		newOrientation = Vector2(cos(angle), sin(angle))

	setNewOrientation(newOrientation)


<<<<<<< Updated upstream
=======



func _on_AnimatedSprite_frame_changed():
	$StepSounds.set_stream(stepSoundsList[randi()%stepSoundsList.size()])
	$StepSounds.play()
	$StepSounds.pitch_scale = rand_range(0.8, 1.2)
>>>>>>> Stashed changes
