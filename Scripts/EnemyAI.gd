extends Node2D

@onready var AITimer = $ActionTimer
@onready var attackTimer = $AttackTimer

var rng = RandomNumberGenerator.new()

@export var dragObject : Sprite2D
@export var gameObject : Control #Object that controls the game
@export var windowObject : Node2D
@export var JumpscareAnimation : AnimationPlayer

@export var AILevel = 8
@export var attackTime = 8
@export var alertSound : AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AITimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_timer_timeout() -> void:
	
	# Gives player 1 hour of invincibility
	if gameObject.totalTimeSeconds < gameObject.seconds2hour:
		return
	
	var rngValue = rng.randi_range(0,20)
		
	print("AI Value: ", rngValue)
	if rngValue <= AILevel:
		print("Enemy takes action")
		
		# Enemy chooses an action
		if rng.randi_range(0,1) == 0:
			# Attack through the floor
			dragObject.initiate_cleaning()
			
		else:
			# Attack through the window
			print("Enemy is on the window!")
			windowObject.isEnemyPresent = true
			windowObject.enemyHealth = windowObject.initialEnemyHealth
		
		# Initiate Timer
		alertSound.play()
		if attackTimer.time_left <= 0:
				attackTimer.start()
		
	else:
		print("Enemy does nothing")

# Player lose state
func _on_attack_timer_timeout() -> void:
	gameObject.goBack()
	await get_tree().create_timer(0.6).timeout
	JumpscareAnimation.play("Jumpscare")
	gameObject.stopGame("GameOver!\n You Died!", 6)
