extends Node2D

@export var goBackNode : BaseButton
@export var floorNode : Node2D  
@export var windowNode : Node2D
@export var lightNode : PointLight2D

@export var footstepSound : AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_floor_area_2d_mouse_entered() -> void:
	#print("Mouse entered")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_floor_area_2d_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	


func _on_floor_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("mouse_click"):
		#print("Transition to the targeted area")
		floorNode.visible = true
		self.visible = false
		goBackNode.visible = true
		footstepSound.play()


func _on_window_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("mouse_click"):
		#print("Transition to the targeted area")
		windowNode.visible = true
		self.visible = false
		goBackNode.visible = true
		footstepSound.play()
		lightNode.visible = false
