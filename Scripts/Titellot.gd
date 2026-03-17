class_name Personatge extends KinematicBody2D

signal ataca(direccio, posicio)
signal GameOver()

var armaMeleeScene = preload("res://Escenes/ArmaMelee.tscn")
var armaDistanciaScene = preload("res://Escenes/ArmaDistancia.tscn")

var weapon

const SPEED = 300  # Velocidad de movimiento del personaje

var _vida := 100
var _vel := Vector2()
var motion = Vector2.ZERO  # Vector de movimiento
var _mirantA  := 0
var _potAtacar := true
var hitteable := true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func grabWeapon(arma):
	weapon = arma
	add_child(weapon)
	weapon.position = $Cos.position # Establece la posición del arma
	weapon.connect('pot_disparar', self, 'potDisparar')
	# Obtiene la referencia al Sprite del arma (asumiendo que weapon es un Node2D)
	var weaponSprite = weapon.get_node("ArmaDist")
	weaponSprite.offset = Vector2(0, -75)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	_vel = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		_vel.x = SPEED
	elif Input.is_action_pressed("move_left"):
		_vel.x = -SPEED   
	
	if Input.is_action_pressed("move_down"): 
		_vel.y = SPEED 
	elif Input.is_action_pressed("move_up"):
		_vel.y = -SPEED

	if _potAtacar and Input.is_action_pressed("ui_up"):
		_potAtacar = false
		emit_signal("ataca", 1, position)
		rotarArma(Vector2(-1, 0))
		weapon.startTimer()
	
	elif _potAtacar and Input.is_action_pressed("ui_left"):
		_potAtacar = false
		emit_signal("ataca", 2, position)
		rotarArma(Vector2(0, 1))
		weapon.startTimer()
	
	elif _potAtacar and Input.is_action_pressed("ui_down"):
		_potAtacar = false
		emit_signal("ataca", 3, position)
		rotarArma(Vector2(1, 0))
		weapon.startTimer()
	
	elif _potAtacar and Input.is_action_pressed("ui_right"):
		_potAtacar = false
		emit_signal("ataca", 4, position)
		rotarArma(Vector2(0, -1))
		weapon.startTimer()
	
	_vel = move_and_slide(_vel)

func potDisparar():
	_potAtacar = true
	
func rotarArma(direccio: Vector2):
	if weapon != null:
		weapon.rotation = direccio.angle()

func _on_TimerInvencibilitat_timeout():
	hitteable = true # Replace with function body.

func _on_Area2D_body_entered(body):
	if body is Enemic and hitteable:
		_vida -= body.damage
		$HUD.update_vida(_vida)
		if _vida <= 0:
			emit_signal('GameOver')
		else:
			$TimerInvencibilitat.start()
			hitteable = false

func set_nEnemics(enemics):
	$HUD.update_nEnemics(enemics)

func set_tempsWave(temps):
	$HUD.tempsPerWave(temps)
