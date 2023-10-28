extends Node

signal item_to_ui(item)

var itemInSlot = 0
const levels = {
	"machine_room" = "res://Scenes/machine_room.tscn",
	"passenger_room" = "res://Scenes/passenger_room.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_do_action(asset_type, args):
	match asset_type:
		"item": 
			item_to_ui.emit(args[0])
