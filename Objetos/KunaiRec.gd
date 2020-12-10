extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bandera=false
var contador=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if bandera:
		position.y-=5
		contador+=5
		if contador>150:
			queue_free()

func _on_RecolectarK_area_entered(area):
	bandera=true
