extends Node2D

const ESC_PERSONATGE := preload('res://Escenes/Titellot.tscn')
const ESC_ENEMIC := preload("res://Escenes/Enemic.tscn")
const ESC_ARMA_MELEE := preload('res://Escenes/ArmaMelee.tscn')
const ESC_ARMA_DIST := preload("res://Escenes/ArmaDistancia.tscn")
const FLETXA := preload("res://Escenes/Fletxa.tscn")

onready var spawner1 = $EnemicsSpawn1
onready var spawner2 = $EnemicsSpawn2
var _personatge
var _arma
var _nEnemics := 1
var enemics := []
var ingame := false

# Called when the node enters the scene tree for the first time.
func _ready():
	_personatge = ESC_PERSONATGE.instance()
	add_child(_personatge)
	_personatge.position = $Spawn.position
	_arma = ESC_ARMA_DIST.instance()
	_personatge.grabWeapon(_arma)
	_personatge.connect("ataca", self, 'personatge_ataca')
	_personatge.connect('GameOver', self, 'fiJoc')
	$BotoInici.connect("botoClicat", self, 'gestioWaves')
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	_personatge.set_tempsWave($WavesTimer.time_left)


func personatge_ataca(direccio:int, posicio: Vector2):
	var bl := (FLETXA.instance() as Fletxa)
	var vd:Vector2
	if direccio == 1:
		vd = Vector2(0, -1)
		bl.global_rotation = vd.angle_to(Vector2(0, -1))
	elif direccio == 2:
		vd = Vector2(-1, 0)
	elif direccio == 3:
		vd = Vector2(0, 1)
		bl.global_rotation = vd.angle_to(Vector2(0, -1))
	elif direccio == 4:
		vd = Vector2(1, 0)
		bl.global_rotation = vd.angle_to(Vector2(0, 1))
	bl.ini(vd, posicio) 
	bl.afegir_emissor(_personatge) # per evitar que toqui el mateix pers. 
	
	for enemic in get_tree().get_nodes_in_group("Enemics"):
		bl.afegir_tocable(enemic.get_child(0)) # és tocable l'Area2D filla del PathFollow
	bl.connect("disparat", self, "_on_bala_disparat")
	add_child(bl,true) # afegim bala a l'arbre de nodes



func _on_WavesTimer_timeout():
	if ingame == true:
		spawnEnemics(spawner1)
		spawnEnemics(spawner2)
		spawnerTimeSet()

func spawnEnemics(spawner):
	var rng = RandomNumberGenerator.new()
	var spawnPosition = setPosicioEnemic(spawner)
	var randomnum = rng.randi_range(0, _nEnemics)
	for i in range(0, randomnum):
		var enemic = ESC_ENEMIC.instance()
		enemic.position = Vector2(spawnPosition.x + (i * 50), spawnPosition.y)
		add_child(enemic)
		add_to_group('Enemics')
		enemic.connect('enemicMort', self, '_on_enemicMort')
		enemics.append(enemic) # Agregar enemigo a la lista
		enemic.setPlayer(_personatge)
	_personatge.set_nEnemics(enemics.size())
	

func spawnerTimeSet():
	$WavesTimer.wait_time = 10
	$WavesTimer.start()
	if _nEnemics <= 5: _nEnemics += 1

func setPosicioEnemic(spawner):
	var spawnPoint = spawner
	var randomX = rand_range(-200, 200)
	var randomY = rand_range(-200, 200)
	var spawnPosition = spawnPoint.position + Vector2(randomX, randomY)	
	return spawnPosition

func fiJoc():
	queue_free()

func _on_enemicMort(enemic):
	enemics.erase(enemic) # Eliminar enemigo de la lista
	enemic.queue_free()
	if enemics == []:
		_on_WavesTimer_timeout()
	_personatge.set_nEnemics(enemics.size())

func gestioWaves():
	if ingame:
		ingame = false
		$WavesTimer.stop()
	else:
		ingame = true
		_on_WavesTimer_timeout()
