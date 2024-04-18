extends Node
class_name Ground

const seed =7
const Grid_size=16.0
var MIN_NUM_POINTS =0
const MAX_HEIGHT= 5000

signal end_point_of_line(num)
var body
var line
var base_level
var flats=[]
var last_point
var line_end
var collider
var new_collider
var origin_point=Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	line=$StaticBody2D/Line2D
	collider=$StaticBody2D/CollisionShape2D
	set_base_level()
	#get_tree().get_root().connect("size_changed",self, "set_base_level")
	add_points(Vector2(0,0))
	body=$StaticBody2D
func set_base_level():
	base_level = get_viewport().size.y -Grid_size
	line.position.y =base_level
	collider.position.y=base_level
func add_points(pos):
	var rng =RandomNumberGenerator.new()
	rng.set_seed(seed)
	add_point(pos)
	MIN_NUM_POINTS+=3000
	spawn_new_collider(pos,origin_point)
	while pos.x< MIN_NUM_POINTS or abs(pos.y)>0:
		origin_point=pos
		pos.x += Grid_size
		pos.y += (rng.randi() % 3-1)* Grid_size
		pos.y = clamp(pos.y,-MAX_HEIGHT,0)
		add_point(pos)
		print(origin_point, " ",pos)
		spawn_new_collider(pos,origin_point)
	print("End Pos %d flats %d" % [pos.x, flats.size()])
	line_end=pos.x
	end_point_of_line.emit(line_end)
	
	
func add_point(p):
	var point =Vector2(p.x,p.y)
	line.add_point(point)
	if last_point and last_point.y==point.y:
		last_point=point
		
	
func spawn_new_collider(pos,new_origin_point):
	collider=CollisionShape2D.new()
	collider.shape =SegmentShape2D.new()
	body=$StaticBody2D
	body.add_child(collider)
	collider.position.y=base_level
	#print(collider, collider.shape)
	collider.shape.set_a(new_origin_point)
	#print(collider,"Start",new_origin_point,"end", pos)
	collider.shape.set_b(pos)
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_character_body_2d_end_of_the_line():
	print("New line generating")
	add_points(Vector2(line_end,0))
	get_children(false)


