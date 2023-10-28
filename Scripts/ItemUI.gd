extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture(preload("res://Assets/Hand.png"))
	get_parent().get_parent().item_to_ui.connect(_on_recived_item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_recived_item(item):
	set_texture(item.texture)
