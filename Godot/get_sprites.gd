extends Node2D
@onready var left_ship=preload("res://from_left_tie.tscn")
var frames= 11
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$gen_sprites_req.connect("request_completed", self._on_request_completed)

	var url = "http://127.0.0.1:5000/generate_images_criteria"
	
	var headers = ["Content-Type: application/json"]
	var data={
	start_x = 50,
	start_y = 50,
	frames = frames,
	seed = 3,
	pixel_number = 100,
	mode = "2",
	wiggle =3,
	xml = 'carrot.xml',
	pixel_size = 2,
	file_name = "asteroid"
		
		
	}
	var body=JSON.stringify(data)
	$gen_sprites_req.request(url,headers,HTTPClient.METHOD_POST,body)

func _on_request_completed(result, response_code, headers, body):
	await(2)
	var json =JSON.parse_string(body.get_string_from_utf8())
	var images =[]
	var filename=""
	print(json["wiggle_0"])
	#for i in range(frames-1):
		#filename="filename_"+str(i)
		#images.append(json[filename])
	var pname=json["wiggle_0"]
	await(4)
	pname=pname.replace("http://localhost:5000/images","res://Python//Images")
	var pic1=Image.load_from_file(pname)
	var pic1_text=ImageTexture.create_from_image(pic1)
	var new_ship=left_ship.instantiate()
	var new_ship_anim=new_ship.get_child(0)
	var new_ship_anim_track=new_ship_anim.get_animation()
	var new_ship_frames=new_ship_anim.get_sprite_frames()
	
	for i in range(frames-1):
		pname=json["wiggle_"+str(i)]
		pname=pname.replace("http://localhost:5000/images","res://Python//Images")
		pic1=Image.load_from_file(pname)
		pic1_text=ImageTexture.create_from_image(pic1)
		new_ship_frames.add_frame(new_ship_anim_track,pic1_text,.5,-1)
	print(json)
	
	$Timer.start()
	
	#new_ship.add_child(new_ship_anim)
	#var falling =Animation.new()
	#new_ship_anim.add_animation("falling", falling)
	#falling.add_track(0)
	#falling.length =2
	#var path=String(new_ship.get_path())+":frame"
	#falling.track_set_path(0,path)
	#
	#for i in range(len(images)):
		#falling.track_insert_key(images[i],.5,0)
	#
	

func spawn_ship():
	var new_ship=left_ship.instantiate()
	new_ship.position=$ship_spawn_intro.position
	
	var velocity = Vector2(randf_range(350.0, 450.0), 0.0)
	
	var direction= get_angle_to($ship_spawn_intro.position)
	direction+=randf_range(-PI / 8, PI / 8)
	#new_ship.look_at(get_global_mouse_position())

	new_ship.rotation =direction
	
	new_ship.linear_velocity=velocity.rotated(direction)	
	add_child(new_ship)
#too doo: loop thorough JSON and assign sprites
#put a sprit on the front page with the gif we jsut generated, asseng from_left and instatiate it
func _exit_tree():
	var dir = DirAccess.open("res://Python//Images")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png") or file_name.ends_with(".import"): 
				dir.remove(file_name)
			file_name = dir.get_next()
func _process(delta):
	pass


func _on_timer_timeout():
	spawn_ship()
