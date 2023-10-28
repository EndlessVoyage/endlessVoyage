extends Node

var itemInSlot = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.picked_up.connect(_on_picked_up_item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
signal item_to_ui(item)

func _on_picked_up_item(item):
	print(item)
	if item == 1:
		itemInSlot = 1
		item_to_ui.emit(1)
		
