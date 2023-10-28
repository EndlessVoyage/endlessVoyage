extends CharacterBody2D

@export var ASSET_TYPE = "Killing_Object"
const SPEED = 300.0
func _ready():
	get_parent().get_node("Trigger").chandelier_triggert.connect(_falling)

func _process(delta):
	pass

func _falling():
	print("test")

