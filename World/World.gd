extends Node2D



onready var player = $Player
onready var salud = $UI/Life/Amount
onready var cantidad_k = $UI/Kunai/Amount
var pauseMenu = load("res://Menu/pausa/PausaUI/PauseMenu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("changeHP", self, "changeHP")
	player.connect("changeKunais", self, "changeKunais")
	


func changeHP(hp):
	salud.text = str(hp)
	
	
func changeKunais(kunais):
	cantidad_k.text = str(kunais)


func _on_PauseButton_pressed():
	
	var pauseMenuInstance = pauseMenu.instance()
	
	add_child(pauseMenuInstance)
