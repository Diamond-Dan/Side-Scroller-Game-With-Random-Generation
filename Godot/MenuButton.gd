extends MenuButton

var pause=false
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("Pause") and pause!=true:
		get_tree().paused=true
		pause=true
		show()
	else:
		get_tree().paused=false
		
