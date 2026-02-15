extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	$CanvasLayer/Main.visible = false
	$CanvasLayer/Newspaper.visible = true
	$AnimationPlayer.play("newspaperFadeIn")
	await get_tree().create_timer(15).timeout
	$AnimationPlayer.play("newspaperFadeOut")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_instructions_button_pressed() -> void:
	$CanvasLayer/Instructions.visible = true
	$CanvasLayer/Main.visible = false


func _on_back_button_pressed() -> void:
	$CanvasLayer/Instructions.visible = false
	$CanvasLayer/Main.visible = true
