extends Node

signal player_burns
signal picked_up_chandelier

var itemInSlot = {currentItem = "", action = ""}
const levels = {
	machine_room = "res://Scenes/machine_room.tscn",
	passenger_room = "res://Scenes/passenger_room.tscn",
	final_room = "res://Scenes/final_room.tscn"
}

var activeLevel: Node2D = null
const HAND_SPRITE = "res://Assets/Hand.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	change_room("machine_room", true)
	$Timer.connect("timeout", _on_timer_timeout)
	$Timer2.connect("timeout",_death)
	$Player/ItemUI.set_texture(preload(HAND_SPRITE))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
func _on_player_do_action(asset_type, args):
	match asset_type:
		"item":
			handle_item(args[0], args[1])
		"door":
			change_room(args[0])
		"Killing_Object":
			_death()
		"puzzle":
			attempt_puzzle(args[0])

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
		if room == "passenger_room":
			$Player.position = Vector2(3338, 907)
	else:
		print("rescourse doesn't exist")
	
func _on_timer_timeout() -> void:
	print("The Generator burned down. You died!")
	player_burns.emit()
	$Timer.stop()
	$Timer2.start()
	
func _death():
	get_tree().change_scene_to_file("res://Scenes/death_transition.tscn")



func handle_item(item: Node2D, action: String):
	if action == "break_open":
		picked_up_chandelier.emit()
	if !item.has_node("Sprite2D"):
		print("-E- Item doesn't contain a Sprite2D")
	else:
		var spriteNode = item.get_node("Sprite2D")
		$Player/ItemUI.set_texture(spriteNode.texture)
		$AudioStreamPlayer2D.play()
	itemInSlot = {currentItem = item.name, action = action}
	item.queue_free()
	
func attempt_puzzle(puzzleNode: Node2D):
	if itemInSlot.currentItem == "":
		# No action required
		return
	if !puzzleNode or !puzzleNode.has_method("process_puzzle_solution"):
		print("-E- puzzleNode invalid")
		return
	if puzzleNode.process_puzzle_solution(itemInSlot.action):
		$Player.solve_puzzle(puzzleNode)
		$Player/ItemUI.set_texture(preload(HAND_SPRITE))
		itemInSlot.currentItem = ""

func on_death():
	pass
