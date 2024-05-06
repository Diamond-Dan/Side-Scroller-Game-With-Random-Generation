extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text="Last High Score: " + var_to_str(Difficulty.last_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
