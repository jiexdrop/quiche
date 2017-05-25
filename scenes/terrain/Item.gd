extends Area2D

func _input_event(viewport, event, shape_idx):
	if(event.type == InputEvent.SCREEN_TOUCH) \
	and event.pressed:
		get_tree().change_scene("res://scenes/MainScene.tscn")