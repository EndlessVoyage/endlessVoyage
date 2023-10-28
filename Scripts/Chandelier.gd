extends CharacterBody2D

@export var ASSET_TYPE = "Killing_Object"
var screen_size
const SPEED = 300.0
func _ready():
	get_parent().chandelier_triggert.connect(_process)

func _process(delta):
	var newVelocity = Vector2.ZERO
	screen_size = Vector2(3840,1080)
	newVelocity.y -= 1
	position += newVelocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

