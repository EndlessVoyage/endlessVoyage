extends Node

signal item_to_ui(item)

var itemInSlot = 0
const levels = {
	machine_room = "res://Scenes/machine_room.tscn",
	passenger_room = "res://Scenes/passenger_room.tscn"
}
var activeLevel: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	change_room(levels.machine_room, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_do_action(asset_type, args):
	match asset_type:
		"item": 
			item_to_ui.emit(args[0])
		"door":
			change_room(args[0])

func change_room(room = "", is_init = false):
	if !is_init:
		self.remove_child(activeLevel)
		
	if ResourceLoader.exists(room):
		var result: Node2D = ResourceLoader.load(room).instantiate()
		activeLevel = result
		result.position = Vector2(1922, 535)
		self.add_child(result)
