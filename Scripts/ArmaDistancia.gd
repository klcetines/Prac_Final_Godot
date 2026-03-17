class_name Arma_a_Distancia extends Node2D

signal pot_disparar()

var cadencia_dispar = 0.5
var dmg = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func startTimer():
	$Timer.start()

func _on_Timer_timeout():
	emit_signal('pot_disparar')
