extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	if Difficulty.num_of_mountains==50:
		
		self.text="Normal Mountains"
	elif Difficulty.num_of_mountains==80:
	
		self.text="More  Mountains"
	elif Difficulty.num_of_mountains==100:
		
		self.text="Even MORE Mountains"
	elif Difficulty.num_of_mountains==300:
	
		self.text="MOSTLY MOUNTAINS EXTREME CAUTION IS ADVISED"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	if Difficulty.num_of_mountains==50:
		Difficulty.num_of_mountains=80
		self.text="More  Mountains"
	elif Difficulty.num_of_mountains==80:
		Difficulty.num_of_mountains=100
		self.text="Even MORE Mountains"
	elif Difficulty.num_of_mountains==100:
		Difficulty.num_of_mountains=300
		self.text="MOSTLY MOUNTAINS EXTREME CAUTION IS ADVISED"
	elif Difficulty.num_of_mountains==300:
		Difficulty.num_of_mountains=50
		self.text="Normal Mountains"
