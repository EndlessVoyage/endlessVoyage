extends Node

signal item_to_ui(item)

var itemInSlot = 0
const levels = {
	"machine_room" = "res://Scenes/machine_room.tscn",
	"passenger_room" = "res://Scenes/passenger_room.tscn"
}
var activeLevel: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if ResourceLoader.exists(levels.machine_room):
		var result: Node2D = ResourceLoader.load(levels.machine_room).instantiate()
		activeLevel = result
		result.position = Vector2(1922, 535)
		self.add_child(result)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_do_action(asset_type, args):
	match asset_type:
		"item": 
			item_to_ui.emit(args[0])
