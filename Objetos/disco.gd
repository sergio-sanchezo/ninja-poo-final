extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var movimiento=0
var count=0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if count==movimiento:
		movimiento*=-1
		count=0
	if movimiento>0:
		position.x+=2
		count+=2
	if movimiento<0:
		position.x-=2
		count-=2
	$DiscoIMG.rotation_degrees+=3
	if($DiscoIMG.rotation_degrees==360):
		$DiscoIMG.rotation_degrees=0
