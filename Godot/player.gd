extends CharacterBody2D
@export var speed = 400
signal end_of_the_line
signal dead
var line_end

func _ready():
	
	var engine_file= _open_mp3(Difficulty.engine)
	var afterburner_file = _open_mp3(Difficulty.afterburner)
	$engine_sound.set_stream(engine_file)
	$engine_sound.play()
	$after_burner_sound.set_stream(engine_file)
func _open_mp3(path):
	var file=FileAccess.open(path,FileAccess.READ)
	var sound=AudioStreamMP3.new()
	sound.data =file.get_buffer(file.get_length())
	return sound	
func get_input():
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	#print(input_direction[0])
	if(input_direction[0]==-1):
		velocity = (input_direction*-1) * speed/4
		
		
	elif(input_direction[0]==1):
		velocity = input_direction * (speed*1)
		$engine_sound.stop()
		if $after_burner_sound.is_playing() == false:
			$after_burner_sound.play()
			$engine_sound.stop()
		print("afterburner")
	else:
		input_direction[0]=.5
		velocity =input_direction *speed
		
	if(input_direction[0]!=1):
		if $engine_sound.is_playing()==false:
			$after_burner_sound.stop()
			$engine_sound.play()
			
func _physics_process(delta):
	get_input()
	var collide_info= move_and_slide()
	if collide_info==true:
		lose_life()
	
	if position.x>=(line_end-1000):
		end_of_the_line.emit()
	
	

func _on_node_2d_end_point_of_line(num):
	line_end=num 

func lose_life():
	#print($MarginContainer/TextureProgressBar.value)
	$MarginContainer/TextureProgressBar.value-=1
	if($MarginContainer/TextureProgressBar.value<=0):
		dead.emit()
