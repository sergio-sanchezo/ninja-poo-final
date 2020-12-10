extends Area2D

var dir=1
export var vel=Vector2(300,0)

func _ready():
	$time_life.start(1.5)
	# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if dir==-1:
		position+=vel*delta*dir
		$Sprite.flip_h=true
	else:
		position+=vel*delta*dir


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Kunai_area_entered(area):
	queue_free()


func _on_time_life_timeout():
	queue_free()
