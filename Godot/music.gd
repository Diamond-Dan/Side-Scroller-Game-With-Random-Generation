extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var music_url="http://127.0.0.1:5001/generate"
	_generate_music(music_url)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _generate_music(music_url):
	var headers = ["Content-Type: application/json"]
	var notes = randi_range(60,120)
	var instruments_array: Array[String]=["violin","guitar","piano","electric_guitar","acoustic_guitar","xylophone"]
	var scales_array: Array[String]=["C_major", "G_major","A_minor","Blues","Pentatonic","E_minor","D_major","A_flat","B_flat", "F_major" ]
	var instruments=instruments_array.pick_random()
	var scales=scales_array.pick_random()
	music_url= music_url+"?"+"num_notes="+str(notes)+"&scale="+scales+"&instrument="+instruments
	$gen_music_req.connect("request_completed", self._music_on_request_completed)
	$gen_music_req.request(music_url,headers,HTTPClient.METHOD_GET)
func _music_on_request_completed(result, response_code, headers, body):
	await(1)
	var music_json =JSON.parse_string(body.get_string_from_utf8())
	
	var music_name=music_json["file"]
	
	music_name=music_name.replace("C:\\Users\\Daniel\\OneDrive\\CS_Major\\361\\361_project\\Godot\\Music Generator\\CS361-MicroserviceA\\uploads\\","res://Music Generator//CS361-MicroserviceA//uploads//")
	await(1)
	var music_file= _open_mp3(music_name)
	
	self.set_stream(music_file)
	self.play()
func _open_mp3(path):
	var file=FileAccess.open(path,FileAccess.READ)
	var sound=AudioStreamMP3.new()
	sound.data =file.get_buffer(file.get_length())
	$music_timer.set_wait_time(sound.get_length())
	$music_timer.start()
	return sound




func _on_music_timer_timeout():
	var music_url="http://127.0.0.1:5001/generate"
	_generate_music(music_url)
