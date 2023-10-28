extends StaticBody2D

@export var state = "unsolved"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", _on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_timer_timeout() -> void:
	print("The Generator burned down. You died!")
	get_tree().reload_current_scene()
