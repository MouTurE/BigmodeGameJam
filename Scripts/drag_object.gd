extends Sprite2D
var dragging = false
var startPos : Vector2
var prevPos : Vector2

@export var enemyNode : Node2D

@export var messNode : Sprite2D
@export var messHealth : float = 100
@export var cleaningSound : AudioStreamPlayer2D


var cleaning = false
var initialMessHealth : float 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startPos = self.global_position
	initialMessHealth = messHealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		self.global_position = get_global_mouse_position()
	else:
		self.global_position = startPos
		
	if cleaning and messHealth > 0:
		if prevPos != self.global_position:
			messHealth -= 2	
			prevPos = self.global_position
			messNode.self_modulate.a = messHealth/initialMessHealth
			cleaningSound.play()
	elif  messHealth <= 0:
		messNode.visible = false
		enemyNode.attackTimer.stop()
		cleaning = false
		


func initiate_cleaning():
	print ("Initiate cleaning")
	messNode.visible = true
	messNode.self_modulate.a = 1
	messHealth = initialMessHealth
	

# Signals
func _on_area_2d_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)
	


func _on_area_2d_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("mouse_click"):
		dragging = true
		
	if Input.is_action_just_released("mouse_click"):
		dragging = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "DragObject":
		cleaning = true
		


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().name == "DragObject":
		cleaning = false
