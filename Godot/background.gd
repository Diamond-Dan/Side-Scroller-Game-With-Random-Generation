extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	var pic1=Image.load_from_file(Difficulty.background_0)
	var pic1_text=ImageTexture.create_from_image(pic1)
	self.set_texture(pic1_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_background_move_timeout():
	self.position.x = self.position.x-1
