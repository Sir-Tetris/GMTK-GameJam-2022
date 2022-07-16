extends StaticBody2D

onready var raycast = $RayCast2D as RayCast2D
onready var line = $Line2D as Line2D
onready var animation = $AnimationPlayer as AnimationPlayer
onready var collision = $CollisionShape2D as CollisionShape2D

var casting := false
var direction : Vector2
var disappearing := false
var parent
	
func set_values(value : Vector2, boss : Object):
	direction = value
	casting = true
	rotation_degrees = rad2deg(direction.angle())
	parent = boss

func _physics_process(delta: float) -> void:
	global_position = parent.global_position + (125*direction)
	if casting:
		var cast_point = raycast.cast_to
		
		if raycast.is_colliding():
			cast_point = raycast.get_collision_point()
			
		line.points[1] = cast_point
		
		animation.play("appear")
#		tween.interpolate_property(line, "width", 0, 10.0, 1)
#		tween.interpolate_property(collision, "scale", Vector2(1, 1), Vector2(1, 5.0), 0.5)

	elif disappearing:
		animation.play("disappear")


func _on_Timer_timeout() -> void:
	disappearing = true

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "appear":
		casting = false
		$Timer.start()
	if anim_name == "disappear":
		queue_free()
