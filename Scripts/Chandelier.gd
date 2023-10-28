extends CharacterBody2D

@export var ASSET_TYPE = "Killing_Object"
@export var ARGS = [null] # needs to be set in _ready
var falling = false
const SPEED = 20.0
func _ready():
	pass

func _process(delta):
	if falling == true:
		var newVelocity = Vector2.ZERO
		newVelocity.y += 1
		newVelocity = newVelocity.normalized() * SPEED
		position += newVelocity


func _on_trigger_body_entered(body):
	print("achtung")
	falling = true
	
