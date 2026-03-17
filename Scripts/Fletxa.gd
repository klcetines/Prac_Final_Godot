class_name Fletxa extends Area2D
# bala amb moviment rectilini uniforme
# quan toca un enemic el mata i desapareix; si toca un StaticBody o 
# surt d'escena, també desapareix 

signal disparat(area) # area tocada

export var _vel:= 700 # píxels per segon
export var _damage := 10
export var _knockback := 25
var _tocables:= []    # éssers afectats per la bala (inj. de depend.)
var _emissors:= []    # éssers que disparen les bales 
var _vdir:= Vector2() # vector velocitat


# inicialitzem el vector velocitat de la bala i la pos inicial
func ini(dir:Vector2, posIni: Vector2):
	position = posIni
	dir = dir.normalized()
	_vdir = dir * _vel
	
# moviment de la bala 
func _process(delta:float):
	position += _vdir * delta 

func afegir_tocable(esser:Node):
	_tocables.append(esser)
	
func afegir_emissor(esser:Node):
	_emissors.append(esser)


# per si s'escapa de la pantalla sense tocar res
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_Fletxa_body_entered(body):
	if not body in _emissors:
		queue_free() # eliminem la bala

func _on_Fletxa_area_entered(area):
	if area in _tocables:
		emit_signal("disparat",area)
	queue_free() # eliminem la bala

func dmg():
	return _damage

func knockback():
	return _knockback
