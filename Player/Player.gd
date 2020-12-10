extends KinematicBody2D

const accel = 100
const max_speed = 200
const gravity = 500
const max_fall_speed = 580
const jump_power = -410

var reload=true
var Kunai=load("res://Player/Kunai.tscn")
var motion = Vector2()
var throw = false
var h_jump = 270

var kunais = 15
var hp = 100

signal changeHP(hp)
signal changeKunais(kunais)


onready var animatedSprite = $AnimatedSprite


func _ready():
	return
	
func _physics_process(delta):
	if global_position.y>900:
		get_tree().change_scene("res://Menu/GameOver/GameOver.tscn")
	if hp==0:
		animatedSprite.animation="Dead"
	if hp>0:
		move_and_slide(motion, Vector2(0, -1))
		move(delta)


func move(delta):
	motion.y += gravity * delta
	if motion.y > max_fall_speed:
		motion.y = max_fall_speed
		
	motion.x = clamp(motion.x, -max_speed, max_speed)

	if Input.is_action_pressed("ui_left") and not throw:
		motion.x -= accel
		animatedSprite.animation = "moveRight"
		animatedSprite.flip_h = true
		
	elif Input.is_action_pressed("ui_right") and not throw:
		motion.x += accel
		animatedSprite.animation = "moveRight"
		animatedSprite.flip_h = false
	
	else:
		motion.x = lerp(motion.x,0,0.4)
		if not throw:
			animatedSprite.animation = "idle"
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up") and not throw:
			motion.y = -sqrt(2*gravity*h_jump)
	
	else:	
		animatedSprite.animation = "jump"
		if Input.is_action_pressed("ui_down"):
			motion.y += 200
	
	if Input.is_action_just_pressed("ui_throw") and is_on_floor() and kunais > 0:
		if kunais>0 and reload:
			animatedSprite.play("throw")
			disparar()
			$Reload.start(1.5)
			reload=false
			throw = true	



func _on_AnimatedSprite_animation_finished():
	if animatedSprite.animation == "throw":
		kunais -= 1
		emit_signal("changeKunais", kunais)
		throw = false
	if animatedSprite.animation=="Dead":
		get_tree().change_scene("res://Menu/GameOver/GameOver.tscn")

func disparar():
	var newKunai= Kunai.instance()
	get_parent().add_child(newKunai)
	if $AnimatedSprite.flip_h==true:
		newKunai.dir=-1
		newKunai.global_position=$pos_bala_left.global_position
	else:
		newKunai.global_position=$pos_bala.global_position
		

func _on_Reload_timeout():
	reload=true


func _on_Hitbox_area_entered(area):
	print(area.name)
	if area.name=="Are_Zombie_2" or area.name=="Are_Zombie":
		hp -= 20
		emit_signal("changeHP", hp)
	if "Disco".is_subsequence_of(area.name):
		hp=0
	if "RecolectarK".is_subsequence_of(area.name):
		kunais+=2
		emit_signal("changeKunais", kunais)




func _on_Trofeo_body_entered(body):
	if body.name =="Player":
		if get_tree().current_scene.name == "Level1":
			get_tree().change_scene("res://World/LEVELS/Level2.tscn")
		elif get_tree().current_scene.name == "Level2":
			get_tree().change_scene("res://World/LEVELS/Level3.tscn")
		else:
			get_tree().change_scene("res://Menu/GameOver/GameOver.tscn")
			

