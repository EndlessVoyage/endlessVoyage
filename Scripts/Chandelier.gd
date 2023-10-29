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
		move_and_slide()
	if get_slide_collision_count() >= 1:
		get_node("Sprite2D").set_texture(preload("res://Assets/Chandelier Broken.png"))
		ASSET_TYPE = "Misc_Object"
		falling = false
		
func _on_trigger_body_entered(body):
	falling = true
