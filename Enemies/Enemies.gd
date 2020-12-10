extends KinematicBody2D
class_name Enemies

#Variables
export var vel=Vector2(0.0, 0.0)
export var gravedad= 1000.0

func _physics_process(delta):
	vel.y+=gravedad*delta
	move_and_slide(vel)
