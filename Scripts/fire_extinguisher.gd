extends Node2D

@onready var sprite = $Sprite2D
@export var ARGS = [null, "extinguish"] # needs to be set in _ready
@export var ASSET_TYPE = "item"

# Called when the node enters the scene tree for the first time.
func _ready():
	ARGS[0] = $Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
