extends Node2D

var is_ascending = false
const TRANSITION_SPEED = 3 # lower is faster

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Once the transition is done, we reset the game
func _process(delta):
	var color = $Sprite2D.modulate;
	var newAlpha = 0.0
	if color.a > 0 and !is_ascending:
		newAlpha = color.a - (delta / TRANSITION_SPEED);
	else:
		if color.a <= 0:
			is_ascending = true
			newAlpha = delta
		newAlpha = color.a + (delta / TRANSITION_SPEED);
	var newColor = Color(color, newAlpha)
	$Sprite2D.modulate = newColor;
	if $Sprite2D.modulate.a >= 1:
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
