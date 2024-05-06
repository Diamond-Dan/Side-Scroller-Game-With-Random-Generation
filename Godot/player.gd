extends CharacterBody2D
@export var speed = 400
signal end_of_the_line
signal dead
var line_end

	
func get_input():
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	#print(input_direction[0])
	if(input_direction[0]==-1):
		velocity = (input_direction*-1) * speed/4
		
		
	elif(input_direction[0]==1):
		velocity = input_direction * (speed*1)
	else:
		input_direction[0]=.5
		velocity =input_direction *speed
func _physics_process(delta):
	get_input()
	var collide_info= move_and_slide()
	if collide_info==true:
		lose_life()
	
	if position.x>=(line_end-1000):
		end_of_the_line.emit()
	
	

func _on_node_2d_end_point_of_line(num):
	line_end=num # Replace with function body.

func lose_life():
	#print($MarginContainer/TextureProgressBar.value)
	$MarginContainer/TextureProgressBar.value-=1
	if($MarginContainer/TextureProgressBar.value<=0):
		dead.emit()
