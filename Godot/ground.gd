extends Node


class_name Ground

const seed =7
const Grid_size=16.0
var MIN_NUM_POINTS =0
const MAX_HEIGHT= 1000000
signal end_point_of_line(num)
var body
var line
var base_level
var flats=[]
var last_point
var line_end
var collider
var new_collider
var origin_point=Vector2(0,0)
var mountain_count=0
var plains_count=50
#@onready var left_ship=preload("res://from_left_tie.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	line=$StaticBody2D/Line2D
	collider=$StaticBody2D/CollisionShape2D
	set_base_level()
	#get_tree().get_root().connect("size_changed",self, "set_base_level")
	add_points(Vector2(0,0))
	body=$StaticBody2D
	
func set_base_level():
	base_level = get_viewport().size.y -Grid_size
	line.position.y =base_level
	collider.position.y=base_level
func add_points(pos):
	var rng =RandomNumberGenerator.new()
	rng.set_seed(seed)
	add_point(pos)
	MIN_NUM_POINTS+=3000
	spawn_new_collider(pos,origin_point)
	while pos.x< MIN_NUM_POINTS or abs(pos.y)>0:
		origin_point=pos
		pos.x += Grid_size
		pos.y += (rng.randi() % 3-1)* Grid_size*2
		pos.y = clamp(pos.y,-MAX_HEIGHT,0)
		
		if plains_count!=0:
			mountain_count=randi_range(30,Difficulty.num_of_mountains)
			origin_point=pos
			pos.x += Grid_size
			pos.y += (rng.randi() % 3-1)* Grid_size*2
			pos.y = clamp(pos.y,-MAX_HEIGHT,0)
			if pos.y<=-50:
				pos.y=Difficulty.lowest_point
				print("lowering the mountain")
			plains_count=plains_count-1
		else:	
			mountain_count=mountain_count-1
			origin_point=pos
			pos.x += Grid_size
			pos.y += (rng.randi() % 3-1)* Grid_size*10
			pos.y = clamp(pos.y,-MAX_HEIGHT,0)
			if mountain_count==0:
				plains_count= randi_range(Difficulty.dif_low,Difficulty.dif_high)
				print("add more plains")
				print(plains_count)
			
		add_point(pos)
		print(origin_point, " ",pos.y)
		spawn_new_collider(pos,origin_point)
	print("End Pos %d flats %d" % [pos.x, flats.size()])
	line_end=pos.x
	end_point_of_line.emit(line_end)
	
	
func add_point(p):
	var point =Vector2(p.x,p.y)
	line.add_point(point)
	if last_point and last_point.y==point.y:
		last_point=point
		
	
func spawn_new_collider(pos,new_origin_point):
	collider=CollisionShape2D.new()
	collider.shape =SegmentShape2D.new()
	body=$StaticBody2D
	body.add_child(collider)
	collider.position.y=base_level
	#print(collider, collider.shape)
	collider.shape.set_a(new_origin_point)
	#print(collider,"Start",new_origin_point,"end", pos)
	collider.shape.set_b(pos)
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_character_body_2d_end_of_the_line():
	print("New line generating")
	add_points(Vector2(line_end,0))
	get_children(false)




func _on_character_body_2d_ready():
	pass # Replace with function body.


#func spawn_ship_on_path():
	#print("tiggered")
	#
	#
	#
	#var ship_loc=$CharacterBody2D/from_left_path/from_left_spawn
	#print(ship_loc.position)
	#var new_ship=left_ship.instantiate()
	#new_ship.position=Vector2(ship_loc.position[0]+$CharacterBody2D.position[0],$CharacterBody2D.position[1]-400)
	#print(new_ship.position)
	#var velocity = Vector2(randf_range(350.0, 450.0), 0.0)
	#var direction= ship_loc.rotation
	#new_ship.linear_velocity=velocity.rotated(direction)
	#add_child(new_ship)
#func _on_from_left_timer_timeout():
	#spawn_ship_on_path()


func _on_character_body_2d_dead():
	Difficulty.last_score=$CharacterBody2D/Score.score
	get_tree().change_scene_to_file("res://intro.tscn")
	
	
func _notification(what):
	if what== NOTIFICATION_WM_CLOSE_REQUEST:
		_delete_music()
		_delete_images()

func _delete_images():
	var dir = DirAccess.open("res://Python//Images")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png") or file_name.ends_with(".import"): 
				dir.remove(file_name)
			file_name = dir.get_next()
	
func _delete_music():
	var dir = DirAccess.open("res://Music_Generator//CS361-MicroserviceA//uploads")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".mid") or file_name.ends_with(".import") or file_name.ends_with(".wav") or file_name.ends_with(".mp3"): 
				print(file_name)
				dir.remove(file_name)
			file_name = dir.get_next()
