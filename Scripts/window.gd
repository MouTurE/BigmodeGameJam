extends Node2D

@onready var forestImage = $ForestImage
@onready var monsterImage = $MonsterImage

@export var flashlightAudio : AudioStreamPlayer2D
@export var enemyGrunt : AudioStreamPlayer2D
@export var enemyGrunt2 : AudioStreamPlayer2D
@export var enemyNode : Node2D
@export var lightNode : PointLight2D

@export var isEnemyPresent = false
var flashlightOn = false
var brightness : float = 0
const flashlightSpeed = 0.1

@export var enemyHealth = 100
var initialEnemyHealth : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialEnemyHealth = enemyHealth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if flashlightOn:
		if !isEnemyPresent:
			# Show outside in the window
			
			if forestImage.self_modulate.a < 1:
				forestImage.self_modulate.a += 0.1
		else:
			# Show monster in the window
			if monsterImage.self_modulate.a < 1:
				monsterImage.self_modulate.a += 0.1
				forestImage.self_modulate.a -= 0.1
			else:
				if enemyHealth > 0:
					enemyHealth -= 1
					#print("Enemy Health: ",enemyHealth)
					if enemyGrunt.playing == false:
						enemyGrunt.play()
					
				else:
					# Monster disappears
					monsterImage.self_modulate.a = 0
					forestImage.self_modulate.a = 1
					enemyNode.attackTimer.stop()
					enemyGrunt.stop()
					enemyGrunt2.play()
					isEnemyPresent = false

func _input(event: InputEvent) -> void:
	if self.visible == false:
		return
	
	
	if Input.is_action_just_pressed("flashlight"):
		flashlightOn = true
		lightNode.visible = true
		flashlightAudio.play()
		
		
				
			
	
	if Input.is_action_just_released("flashlight"):
		flashlightOn = false
		lightNode.visible = false
		#print("Flashlight Off")
		
		if !isEnemyPresent:
			for i in range(11,0,-2):
				forestImage.self_modulate.a = float(i)/10
				await get_tree().create_timer(0.02).timeout
		
			forestImage.self_modulate.a = 0
		else:
			for i in range(11,0,-2):
				monsterImage.self_modulate.a = float(i)/10
				await get_tree().create_timer(0.02).timeout
		
			monsterImage.self_modulate.a = 0
