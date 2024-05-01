extends CharacterBody2D

@export var speed = 400
signal end_of_the_line
var line_end
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	if position.x>=(line_end-1000):
		end_of_the_line.emit()
	

func _on_node_2d_end_point_of_line(num):
	line_end=num # Replace with function body.
