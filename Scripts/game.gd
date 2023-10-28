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
	change_room("machine_room", true)
	$Timer.connect("timeout", _on_timer_timeout)
	$Timer2.connect("timeout",_death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_do_action(asset_type, args):
	match asset_type:
		"item": 
			item_to_ui.emit(args[0])
		"door":
			change_room(args[0])
		"Killing_Object":
			_death()

func change_room(room = "", is_init = false):
	if !is_init:
		self.remove_child(activeLevel)
		
	if ResourceLoader.exists(levels[room]):
		var result: Node2D = ResourceLoader.load(levels[room]).instantiate()
		activeLevel = result
		var newPosition = Vector2(0,0)
		newPosition = Vector2(1922, 535)
		result.position = newPosition
		self.add_child(result)
	else:
		print("rescourse doesn't exist")
	
signal player_burns
func _on_timer_timeout() -> void:
	print("The Generator burned down. You died!")
	player_burns.emit()
	$Timer2.start()
	
func _death():
	get_tree().reload_current_scene()
	
func on_death():
	pass
