extends Path2D
@onready var left_ship=preload("res://from_left_tie.tscn")
var start_height
# Called when the node enters the scene tree for the first time.
func _ready():
	$from_left_timer.start
	start_height=%CharacterBody2D.position.y*-1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if start_height-%CharacterBody2D.position.y<=480:
		$from_left_timer.wait_time=2
	elif start_height-%CharacterBody2D.position.y>=680 and start_height-%CharacterBody2D.position.y<880 :
		$from_left_timer.wait_time=1
	elif start_height-%CharacterBody2D.position.y>=880:
		$from_left_timer.wait_time=.2
func spawn_ship_on_path():
	print("tiggered")
	print($from_left_timer.wait_time)
	print(start_height-%CharacterBody2D.position.y)
	
	var ship_loc=$from_left_spawn
	ship_loc.progress_ratio=randf()
	
	var new_ship=left_ship.instantiate()
	#new_ship.position=Vector2(ship_loc.position[0]+get_parent().position[0],get_parent().position[1]-200)
	new_ship.position=ship_loc.position
	
	var velocity = Vector2(randf_range(350.0, 450.0), 0.0)
	
	var direction= get_angle_to(%CharacterBody2D.position)
	direction+=randf_range(-PI / 8, PI / 8)
	#new_ship.look_at(get_global_mouse_position())

	new_ship.rotation =direction
	
	new_ship.linear_velocity=velocity.rotated(direction)
	
	add_child(new_ship)
func _on_from_left_timer_timeout():
	spawn_ship_on_path()
