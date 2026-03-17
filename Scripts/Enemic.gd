class_name Enemic extends KinematicBody2D

signal enemicMort(enemic)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player: Node2D
var speed = 10000

var vida = 50
var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setPlayer(personatge):
	player = personatge

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = (player.global_position - global_position).normalized()
	# Mueve al enemigo hacia el jugador
	move_and_slide(direction * speed * delta)


func _on_Area2D_area_entered(area):
	if area is Fletxa:
		vida -= area._damage
		if vida <= 0:
			emit_signal('enemicMort', self)
		else:
			var enemyPosition = get_global_position()
			var knockbackVector = area._knockback * area._vdir.normalized() 
			enemyPosition += knockbackVector
			set_global_position(enemyPosition)
