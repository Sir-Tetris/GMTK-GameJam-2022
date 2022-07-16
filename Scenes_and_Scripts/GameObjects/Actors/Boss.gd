extends Actor

export(PackedScene) var laser 
var player
var nextPos


var facesData := {}

signal onRoll

enum Direction{
	X_PLUS,
	X_MINUS,
	Y_PLUS,
	Y_MINUS
}

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




func _on_TurnClock_timeout():
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
	
	adjustDiceFaces(dir)
	
	emit_signal("onRoll")
	$SpriteRoot/DiceAnimationSprite.play("Roll")
	$AnimationPlayer.play("Roll")
	

# handles dice "jumps"
#func spin(toTile:Vector2) -> void:

# Adjusts the faces accordingly to the rolling direction
func adjustDiceFaces(rollDirection:int) -> void:
	var oldTop = facesData.top
	
	if rollDirection == Direction.X_PLUS:
		facesData.top = facesData.left
		facesData.left = facesData.bottom
		facesData.bottom = facesData.right
		facesData.right = oldTop
		rotation = PI / 2.0
	elif rollDirection == Direction.X_MINUS:
		facesData.top = facesData.right
		facesData.right = facesData.bottom
		facesData.bottom = facesData.left
		facesData.left = oldTop
		rotation = 3 * PI / 2
	elif rollDirection == Direction.Y_PLUS:
		facesData.top = facesData.down
		facesData.down = facesData.bottom
		facesData.bottom = facesData.up
		facesData.up = oldTop
		rotation = PI
	elif rollDirection == Direction.Y_MINUS:
		facesData.top = facesData.up
		facesData.up = facesData.bottom
		facesData.bottom = facesData.down
		facesData.down = oldTop
		rotation = 0
	
	
	$Control/Label.text = str(facesData.top)
	if facesData.top == 6:
		laser_attack(Vector2.UP)
		laser_attack(Vector2.RIGHT)
		laser_attack(Vector2.DOWN)
		laser_attack(Vector2.LEFT)

# Resets the animation data once the roll is finished
func _on_DiceAnimationSprite_animation_finished():
	$SpriteRoot/DiceAnimationSprite.playing = false
	$SpriteRoot/DiceAnimationSprite.frame = 0
	$AnimationPlayer.play("RESET")
	position = nextPos
	$AudioStreamPlayer2D.play()
	$SpriteRoot/ParticlesAnimation.show()
	$SpriteRoot/ParticlesAnimation.play()


func _on_ParticlesAnimation_animation_finished():
	$SpriteRoot/ParticlesAnimation.playing = false
	$SpriteRoot/ParticlesAnimation.frame = 0
	$SpriteRoot/ParticlesAnimation.hide()

func laser_attack(direction):
	var laser_instance = laser.instance()
	get_tree().current_scene.add_child(laser_instance)
	laser_instance.set_values(direction, self)
