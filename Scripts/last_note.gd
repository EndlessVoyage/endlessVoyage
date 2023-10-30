extends Node2D

var is_ascending = false
const TRANSITION_SPEED = 1.5 # lower is faster

# Called when the node enters the scene tree for the first time.
func _ready():
	$NormalNote.play("default")
	$Timer.start()

# Once the transition is done, we reset the game
func _process(delta):
	if !is_ascending:
		return
	
	var color = $Sprite2D.modulate;
	var newAlpha = 0.0
	if !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()

	if color.a <= 0:
		is_ascending = true
		newAlpha = delta
	newAlpha = color.a + (delta / TRANSITION_SPEED);
	var newColor = Color(color, newAlpha)
	$Sprite2D.modulate = newColor;
	if $Sprite2D.modulate.a >= 1:
		get_tree().change_scene_to_file("res://Scenes/death_transition.tscn")


func _on_timer_timeout():
	$NormalNote.visible = false
	$BurningNote.visible = true
	$BurningNote.play()
	is_ascending = true
