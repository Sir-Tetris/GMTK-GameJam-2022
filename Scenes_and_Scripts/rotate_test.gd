extends Label

var axes = {"axis1": [2, 3, 5, 4],
"axis2": [1, 4, 6, 3],
"axis3": [1, 2, 6, 5]
}

var x_axis : Array
var y_axis : Array
var top = 1
var face = 2
var right = 4

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_right"):
		find_axes()
		right = top
		var top_index = overflow_check(x_axis, top, -1)
		top = x_axis[top_index]

	elif event.is_action_pressed("move_left"):
		find_axes()
		top = right
		var right_index = overflow_check(x_axis, right, 1)
		right = x_axis[right_index]

	elif event.is_action_pressed("move_up"):
		find_axes()
		top = face
		var face_index = overflow_check(y_axis, face, 1)
		face = y_axis[face_index]

	elif event.is_action_pressed("move_down"):
		find_axes()
		face = top
		var top_index = overflow_check(y_axis, top, -1)
		top = y_axis[top_index]
		
	
func overflow_check(axis : Array, value : int, increment : int) -> int:
	if axis.find(value) == 3 and increment == 1:
		value = 0
		
	elif axis.find(value) == 0 and increment == -1:
		value = 3
		
	else:
		value = axis.find(value + increment)
		
	return value 
	
func _process(delta: float) -> void:
	text = "top " + str(top) + " , face: " + str(face) + ", right: " + str(right) + ", y_axis: " + str(y_axis) + ", x_axis: " + str(x_axis)

func find_axes():
	for i in axes:
		var axis = axes[i]
		if axis.has(top) and axis.has(face):
			if axis.find(face) - axis.find(top) == 1 or axis.find(top) - axis.find(face) == 3:
				y_axis = axis
			else: 
				y_axis = axis
				y_axis.invert()

		if axis.has(top) and axis.has(right):
			if axis.find(right) - axis.find(top) == 1 or axis.find(top) - axis.find(right) == 3:
				x_axis = axis
			else: 
				x_axis = axis
				x_axis.invert()
