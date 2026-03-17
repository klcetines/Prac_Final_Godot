extends Node

const ESC_JOC := preload('res://Escenes/Joc.tscn')
const ESC_INICI := preload('res://Escenes/Inici.tscn')

var escenes := {}

# Called when the node enters the scene tree for the first time.
func _ready():
	escenes['Partida'] = ESC_JOC # Replace with function body.
	escenes['Inici'] = ESC_INICI
	
	change_scene_to('Inici')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_scene_to(sceneName):
	if escenes.has(sceneName):
		get_tree().change_scene_to(escenes[sceneName])
	else:
		print("La escena '" + sceneName + "' no existe en el diccionario de escenas.")
