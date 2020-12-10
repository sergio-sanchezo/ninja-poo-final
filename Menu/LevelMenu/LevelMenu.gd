extends CanvasLayer


func _ready():
	pass # Replace with function body.



func _on_Level1_pressed():
	get_tree().change_scene("res://World/LEVELS/Level1.tscn")


func _on_Level2_pressed():
	get_tree().change_scene("res://World/LEVELS/Level2.tscn")


func _on_Level3_pressed():
	get_tree().change_scene("res://World/LEVELS/Level3.tscn")


func _on_Return_pressed():
	get_tree().change_scene("res://Menu/Principal/MainMenu.tscn")
