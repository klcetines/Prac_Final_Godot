extends Control

onready var _barraVida = $TextureProgress
onready var _nEnemics = $nEnemics

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func update_vida(vida):
	_barraVida.value  = vida

func update_nEnemics(num):
	_nEnemics.set_text('Num. Enemics: ' + str(num))

func tempsPerWave(num):
	$tempsWave.set_text('Següent Wave en : ' + str(round(num)))
