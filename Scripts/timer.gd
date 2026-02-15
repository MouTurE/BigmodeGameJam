extends Control

@export var seconds2hour : int
@onready var ClockText = $ClockText

@onready var clockTimer = $ClockTimer
@export var enemyTimer : Timer

@onready var goBackZone = $GoBackZone
@onready var totalTimeSeconds : int = 0 

@export var cameraNode : Camera2D
@export var lightNode : PointLight2D

@export var winSound : AudioStreamPlayer2D 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clockTimer.start()

func goBack():
	var areas = get_tree().get_nodes_in_group("Area")
		
	for area in areas:
		if area.name != "MainArea":
			area.visible = false
		else:
			area.visible = true
	
	#print(areas)
	goBackZone.visible = false
	lightNode.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	
	# Camera moves depending on mouse offset
	var mouse_offset = (get_viewport().get_mouse_position() - Vector2(get_viewport().size) / 2)
	cameraNode.position = lerp(Vector2(), mouse_offset.normalized() * 100, mouse_offset.length() / 1000)
	
	# Light follows mouse position
	lightNode.position = lerp(Vector2(), mouse_offset.normalized(), mouse_offset.length());
	

	if goBackZone.is_hovered():
		goBack()



func stopGame(text : String, time : float):
	clockTimer.stop()
	enemyTimer.stop()
	ClockText.text = text
	
	await get_tree().create_timer(time).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_timer_timeout() -> void:
	totalTimeSeconds += 1
	var currenthour = 0
	
	# Updates display
	if totalTimeSeconds >= seconds2hour:
		currenthour = totalTimeSeconds/seconds2hour
		ClockText.text = '%d' % [currenthour] + " AM"
	
	# Player win state
	if currenthour >= 6:
		ClockText.vertical_alignment = VerticalAlignment.VERTICAL_ALIGNMENT_CENTER
		ClockText.horizontal_alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_CENTER
		$BlackScreen.visible = true
		goBack()
		stopGame("6 AM\nNight Finished!", 4)
		await  get_tree().create_timer(1).timeout
		$Confetti.emitting = true
		winSound.play()
		
		
		
		
	
