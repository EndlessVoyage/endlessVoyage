extends Node

signal item_to_ui(item)

var itemInSlot = 0
const levels = {
	"machine_room" = "res://Scenes/machine_room.tscn",
	"passenger_room" = "res://Scenes/passenger_room.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.picked_up.connect(_on_picked_up_item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_picked_up_item(item):
		item_to_ui.emit(item)

