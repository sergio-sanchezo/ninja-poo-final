extends CanvasLayer

func _ready():
	get_tree().paused = true


func _on_Resume_pressed():
	get_tree().paused = false
	queue_free()


func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Return_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Menu/Principal/MainMenu.tscn")
