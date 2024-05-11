extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$gen_sprites_req.connect("request_completed", self._on_request_completed)

	var url = "http://127.0.0.1:5000/generate_images_criteria"
	
	var headers = ["Content-Type: application/json"]
	var data={
	start_x = 50,
	start_y = 50,
	frames = 10,
	seed = 3,
	pixel_number = 100,
	mode = "2",
	wiggle =3,
	xml = 'tie_fighter.oxs',
	pixel_size = 2,
	file_name = "asteroid"
		
		
	}
	var body=JSON.stringify(data)
	$gen_sprites_req.request(url,headers,HTTPClient.METHOD_POST,body)

func _on_request_completed(result, response_code, headers, body):
	var json =JSON.parse_string(body.get_string_from_utf8())
	
	print(json)
#too doo: loop thorough JSON and assign sprites
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
