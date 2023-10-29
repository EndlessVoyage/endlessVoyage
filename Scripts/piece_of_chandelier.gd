extends StaticBody2D


@onready var sprite = $Sprite2D
@export var ARGS = [null, "break_open"] # needs to be set in _ready
@export var ASSET_TYPE = "item"

# Called when the node enters the scene tree for the first time.
func _ready():
	ARGS[0] = $Sprite2D
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

