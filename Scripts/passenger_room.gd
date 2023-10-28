extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

signal chandelier_triggert
func _on_trigger_body_entered(body):
	chandelier_triggert.emit()

