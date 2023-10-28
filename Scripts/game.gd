extends Node

var itemInSlot = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Player").picked_up.connect(_on_picked_up_item)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_picked_up_item():
	print("test")
