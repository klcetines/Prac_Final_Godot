extends Sprite

signal botoClicat()

onready var spriteButton = self
var activat := true
var texturaParar = load("res://Sprites/BotoPerParar.png")
var texturaIniciar = load("res://Sprites/BotoPerIniciar.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print(body is Personatge)
	if body is Personatge and activat:
		spriteButton.texture = texturaParar
		activat = false
		emit_signal('botoClicat')
	elif body is Personatge:
		spriteButton.texture = texturaIniciar
		activat = true
		emit_signal('botoClicat')
