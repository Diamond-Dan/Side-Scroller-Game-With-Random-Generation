extends MenuBar


var pause=false
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("Pause") and pause!=true:
		get_tree().paused=true
		pause=true
		$quit_but.show()
	elif event.is_action_pressed("Pause") and pause==true:
		get_tree().paused=false
		pause=false
		$quit_but.hide()


func _on_quit_but_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_file("res://intro.tscn")
