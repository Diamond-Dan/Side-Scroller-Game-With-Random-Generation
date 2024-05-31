extends RigidBody2D
var mob_types

# Called when the node enters the scene tree for the first time.
func _ready():
	mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var skin=randi_range(0,1)
	
	$AnimatedSprite2D.play(mob_types[skin])
	
	var file=FileAccess.open(Difficulty.explosion,FileAccess.READ)
	var sound=AudioStreamWAV.new()
	sound.data =file.get_buffer(file.get_length())
	sound.mix_rate=44100
	sound.set_format(1)
	$explode_sound.set_stream(sound)
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(get_colliding_bodies()[0].is_in_group("player")):
		print(get_colliding_bodies())
		$explode_sound.play()
	$AnimatedSprite2D.play(mob_types[2])
	print("sound")
	print($explode_sound.get_stream())
	$despawn_timer.start()
	$collision_timer.start()
	
	


func _on_timer_timeout():
	queue_free() # Replace with function body.


func _on_collision_timer_timeout():
	$CollisionShape2D.disabled=true
	set_collision_layer_value(1,false)


func _on_life_time_timer_timeout():
	queue_free()
