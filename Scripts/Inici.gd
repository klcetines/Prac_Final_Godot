extends CanvasLayer


const ESC_JOC := preload('res://Escenes/Joc.tscn')

var escenes = {}

func _ready():
	pass

func _on_Jugar_pressed():
	var global_data = get_node("/root/global") # Accede al nodo Autoload
	global_data.change_scene_to('Partida') # Cambia a la escena "Partida"
	


func _on_Sortir_pressed():
	get_tree().quit()

