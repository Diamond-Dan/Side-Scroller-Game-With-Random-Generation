extends Node2D
@onready var left_ship=preload("res://from_left_tie.tscn")
var frames= 11
var global_anim_name_1="asteroid_1"
var global_anim_name_2="asteroid_2"
var global_anim_name_3="explode"
var global_anim_count=0
# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite_url = "http://127.0.0.1:5000/generate_images_criteria"
	var music_url="http://127.0.0.1:5001/generate"

	_generate_sprite(sprite_url)
	_generate_music(music_url)

func _generate_sprite(url):
	var dir = DirAccess.open("res://Python//patterns")
	var patternlist=[]
	if dir:
		patternlist=dir.get_files_at("res://Python//patterns")
	
	var strings_list: Array[String]
	strings_list.assign(patternlist)
	
	var random_guided_image= strings_list.pick_random()
	$gen_sprites_req.connect("request_completed", self._on_request_completed)
	

	
	var headers = ["Content-Type: application/json"]
	var data={
	start_x = 50,
	start_y = 50,
	frames = frames,
	seed = 3,
	pixel_number = 100,
	mode = "2",
	wiggle =6,
	xml = random_guided_image,
	pixel_size = 2,
	file_name = random_guided_image
		
		
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
	new_ship_anim.set_animation(global_anim_name_3)
	var new_ship_anim_explode=new_ship_anim.get_animation()
	var new_ship_frames_explode=new_ship_anim.get_sprite_frames()
	for i in range(frames-1):
		pname=json["explode_"+str(i)]
		pname=pname.replace("http://localhost:5000/images","res://Python//Images")
		pic1=Image.load_from_file(pname)
		pic1_text=ImageTexture.create_from_image(pic1)
		new_ship_frames_explode.add_frame(new_ship_anim_explode,pic1_text,.5,-1)
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
		print(dir)
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".mid") or file_name.ends_with(".import") or file_name.ends_with(".wav") or file_name.ends_with(".mp3"): 
				print(file_name)
				dir.remove(file_name)
			file_name = dir.get_next()


func _generate_music(music_url):
	var headers = ["Content-Type: application/json"]
	var notes = randi_range(30,60)
	var instruments_array: Array[String]=["violin","guitar","piano","electric_guitar","acoustic_guitar","xylophone"]
	var scales_array: Array[String]=["C_major", "G_major","A_minor","Blues","Pentatonic","E_minor","D_major"]
	var instruments=instruments_array.pick_random()
	var scales=scales_array.pick_random()
	music_url= music_url+"?"+"num_notes="+str(notes)+"&scale="+scales+"&instrument="+instruments
	$gen_music_req.connect("request_completed", self._music_on_request_completed)
	$gen_music_req.request(music_url,headers,HTTPClient.METHOD_GET)
func _music_on_request_completed(result, response_code, headers, body):
	await(2)
	var music_json =JSON.parse_string(body.get_string_from_utf8())
	
	var music_name=music_json["file"]
	
	music_name=music_name.replace("C:\\Users\\Daniel\\OneDrive\\CS_Major\\361\\361_project\\Godot\\Music Generator\\CS361-MicroserviceA\\uploads\\","res://Music Generator//CS361-MicroserviceA//uploads//")
	await(2)
	var music_file= _open_mp3(music_name)
	
	$music.set_stream(music_file)
	$music.play()
func _open_mp3(path):
	var file=FileAccess.open(path,FileAccess.READ)
	var sound=AudioStreamMP3.new()
	sound.data =file.get_buffer(file.get_length())
	return sound
func _process(delta):
	pass


func _on_timer_timeout():
	spawn_ship()
	
