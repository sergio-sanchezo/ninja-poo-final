extends Enemies
var direccion=1
var timeout=true
var count=0
func _physics_process(delta):
	if timeout:
		if vel.x==0:
			vel.x=100*direccion
		if not $Ray_Zombie_Left.is_colliding():       #Direcciones de movimiento
			vel.x*=-1
			direccion=1
			$spr_Zombie.flip_h=false
			$Are_Zombie/Coll_Are_Zombie.disabled=false
			$Are_Zombie_2/Coll_Are2_Zombie.disabled=true
		elif not $Ray_Zombie_Right.is_colliding():
			$Are_Zombie_2/Coll_Are2_Zombie.disabled=false
			$Are_Zombie/Coll_Are_Zombie.disabled=true
			vel.x*=-1
			direccion=-1
			$spr_Zombie.flip_h=true

func _on_spr_Zombie_animation_finished():
	if $spr_Zombie.animation=="Attack":
		$spr_Zombie.animation="Walk"
	if $spr_Zombie.animation=="Dead":
		queue_free()
	if $spr_Zombie.animation=="Idle" and name!="Zombie":
		$spr_Zombie.animation="Walk"


func _on_Are_Zombie_area_entered(area):
	if area.name=="Hitbox":
		if timeout:
			$spr_Zombie.animation="Attack"
			$Attack_Time.start(0.8)
			vel.x=0
			timeout=false
	


func _on_Attack_Time_timeout():
	timeout=true


func _on_Are_Zombie_2_area_entered(area):
	if area.name=="Hitbox":
		if timeout:
			$spr_Zombie.animation="Attack"
			$Attack_Time.start(0.8)
			vel.x=0
			timeout=false


func _on_Are_Disparos_area_entered(area):
	if area.name=="Kunai" and (!"Robot".is_subsequence_of(name) and !"Boss".is_subsequence_of(name)):
		$Are_Zombie/Coll_Are_Zombie.queue_free()
		$Are_Zombie_2/Coll_Are2_Zombie.queue_free()
		$Are_Disparos/Coll_Are_Disp.queue_free()
		$spr_Zombie.position.y+=20
		$spr_Zombie.animation="Dead"
		$Attack_Time.start(2)
		vel.x=0
		timeout=false
	if area.name=="Kunai" and ("Robot".is_subsequence_of(name) or "Boss".is_subsequence_of(name)):
		count+=1
		if count==3:
			$Are_Zombie/Coll_Are_Zombie.queue_free()
			$Are_Zombie_2/Coll_Are2_Zombie.queue_free()
			$Are_Disparos/Coll_Are_Disp.queue_free()
			vel.x=0
			$Attack_Time.start(2)
			timeout=false
			$spr_Zombie.animation="Dead"
		else:
			$Attack_Time.start(1)
			timeout=false
			$spr_Zombie.animation="Idle"
			vel.x=0
