extends CharacterBody2D

@export var ASSET_TYPE = "Killing_Object"
@export var ARGS = [null] # needs to be set in _ready
var falling = false
const SPEED = 20.0
var picked_up = false
func _ready():
	get_parent().get_parent().picked_up_chandelier.connect(_piece_picked_up)

func _process(delta):
	if falling == true:
		var newVelocity = Vector2.ZERO
		newVelocity.y += 1
		newVelocity = newVelocity.normalized() * SPEED
		position += newVelocity
		move_and_slide()
	if get_slide_collision_count() >= 1:
		if picked_up == false:
			get_node("Sprite2D").play("broken_shining")
		ASSET_TYPE = "Misc_Object"
		falling = false

func _piece_picked_up():
	picked_up = true
	get_node("Sprite2D").play("broken")

func _on_trigger_body_entered(body):
	falling = true
