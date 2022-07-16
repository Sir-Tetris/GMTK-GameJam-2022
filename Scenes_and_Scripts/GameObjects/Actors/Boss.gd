extends Actor
<<<<<<< Updated upstream


var player
var nextPos
=======
class_name Boss


var player
var nextTile
var bIsAttacking:bool = false
>>>>>>> Stashed changes


var facesData := {}

signal onRoll

<<<<<<< Updated upstream
enum Direction{
	X_PLUS,
	X_MINUS,
	Y_PLUS,
	Y_MINUS
}
=======
var currentTile
>>>>>>> Stashed changes

# Called when the node enters the scene tree for the first time.
func _ready():
	var facesAvailable = [1, 2, 3, 4, 5, 6]
	
	facesData.top = facesAvailable[randi() % 6]
	facesData.bottom = 7 - facesData.top
	facesAvailable.erase(facesData.top)
	facesAvailable.erase(facesData.bottom)
	facesData.right = facesAvailable[randi() % 4]
	facesData.left = 7 - facesData.right
	facesAvailable.erase(facesData.right)
	facesAvailable.erase(facesData.left)
	facesData.up = facesAvailable[randi() % 2]
	facesData.down = 7 - facesData.up
	
	$Control/Label.text = str(facesData.top)
	
	$SpriteRoot/ParticlesAnimation.hide()
<<<<<<< Updated upstream

=======
	
	currentTile = Vector2(floor(position.x / Pathfinder.TileSize), floor(position.y / Pathfinder.TileSize))
	print(currentTile)
>>>>>>> Stashed changes



func _on_TurnClock_timeout():
<<<<<<< Updated upstream
	roll()



# Called to enter a simple roll on side
func roll():
	var dist = player.position - position
	
	var bXAxisRoll = abs(dist.x) > abs(dist.y)
	
	var dir
	
	if bXAxisRoll:
		nextPos = Vector2(position.x + 250 * abs(dist.x) / dist.x, position.y)
		if dist.x > 0:
			dir = Direction.X_PLUS
		else:
			dir = Direction.X_MINUS
	else:
		nextPos = Vector2(position.x, position.y + 250 * abs(dist.y) / dist.y)
		if dist.y > 0:
			dir = Direction.Y_PLUS
		else:
			dir = Direction.Y_MINUS
=======
	var dir = chooseRollDirection()
	roll(dir)

func chooseRollDirection() -> int:
	if not is_instance_valid(player):
		return -1
		
		
	var path = Pathfinder.getPath(currentTile, Pathfinder.getTileFromPosition(player.position))
	print(path)
	var dir:int
	if path.size() > 1:
		nextTile = path[1]
		dir = Pathfinder.getDirectionFromVector(nextTile - currentTile)
	else :
		print("ERROR PATHFINDING")
		dir = Pathfinder.Direction.ERROR
#
#	var dist = player.position - position
#
#	var bXAxisRoll = abs(dist.x) > abs(dist.y)
#
#
#	if bXAxisRoll:
#		nextTile = Vector2(position.x + 250 * abs(dist.x) / dist.x, position.y)
#		if dist.x > 0:
#			dir = Pathfinder.Direction.X_PLUS
#		else:
#			dir = Pathfinder.Direction.X_MINUS
#	else:
#		nextTile = Vector2(position.x, position.y + 250 * abs(dist.y) / dist.y)
#		if dist.y > 0:
#			dir = Pathfinder.Direction.Y_PLUS
#		else:
#			dir = Pathfinder.Direction.Y_MINUS
			
	return dir

# Called to enter a simple roll on side
func roll(dir:int):
	if not is_instance_valid(player):
		return 
		

	bIsAttacking = true
>>>>>>> Stashed changes
	
	adjustDiceFaces(dir)
	
	emit_signal("onRoll")
	$SpriteRoot/DiceAnimationSprite.play("Roll")
<<<<<<< Updated upstream
	$AnimationPlayer.play("Roll")
=======
#	$AnimationPlayer.play("Roll")
	$Tween.interpolate_property(self, "position", position, Pathfinder.getPositionFromTile(nextTile), 1)
	$Tween.start()
	
	currentTile = currentTile + Pathfinder.getVectorFromDirection(dir)
	print(currentTile)
>>>>>>> Stashed changes
	

# handles dice "jumps"
#func spin(toTile:Vector2) -> void:

<<<<<<< Updated upstream
# Adjusts the faces accordingly to the rolling direction
func adjustDiceFaces(rollDirection:int) -> void:
	var oldTop = facesData.top
	
	if rollDirection == Direction.X_PLUS:
=======
# Adjusts the faces accordingly to the rolling Pathfinder.Direction
func adjustDiceFaces(rollDirection:int) -> void:
	var oldTop = facesData.top
	
	if rollDirection == Pathfinder.Direction.X_PLUS:
>>>>>>> Stashed changes
		facesData.top = facesData.left
		facesData.left = facesData.bottom
		facesData.bottom = facesData.right
		facesData.right = oldTop
		rotation = PI / 2.0
<<<<<<< Updated upstream
	elif rollDirection == Direction.X_MINUS:
=======
	elif rollDirection == Pathfinder.Direction.X_MINUS:
>>>>>>> Stashed changes
		facesData.top = facesData.right
		facesData.right = facesData.bottom
		facesData.bottom = facesData.left
		facesData.left = oldTop
		rotation = 3 * PI / 2
<<<<<<< Updated upstream
	elif rollDirection == Direction.Y_PLUS:
=======
	elif rollDirection == Pathfinder.Direction.Y_PLUS:
>>>>>>> Stashed changes
		facesData.top = facesData.down
		facesData.down = facesData.bottom
		facesData.bottom = facesData.up
		facesData.up = oldTop
		rotation = PI
<<<<<<< Updated upstream
	elif rollDirection == Direction.Y_MINUS:
=======
	elif rollDirection == Pathfinder.Direction.Y_MINUS:
>>>>>>> Stashed changes
		facesData.top = facesData.up
		facesData.up = facesData.bottom
		facesData.bottom = facesData.down
		facesData.down = oldTop
		rotation = 0
	
	
	$Control/Label.text = str(facesData.top)


# Resets the animation data once the roll is finished
func _on_DiceAnimationSprite_animation_finished():
	$SpriteRoot/DiceAnimationSprite.playing = false
	$SpriteRoot/DiceAnimationSprite.frame = 0
	$AnimationPlayer.play("RESET")
<<<<<<< Updated upstream
	position = nextPos
	$AudioStreamPlayer2D.play()
	$SpriteRoot/ParticlesAnimation.show()
	$SpriteRoot/ParticlesAnimation.play()
=======
#	position = nextTile
	$AudioStreamPlayer2D.play()
	$SpriteRoot/ParticlesAnimation.show()
	$SpriteRoot/ParticlesAnimation.play()
	bIsAttacking = false
>>>>>>> Stashed changes


func _on_ParticlesAnimation_animation_finished():
	$SpriteRoot/ParticlesAnimation.playing = false
	$SpriteRoot/ParticlesAnimation.frame = 0
	$SpriteRoot/ParticlesAnimation.hide()
