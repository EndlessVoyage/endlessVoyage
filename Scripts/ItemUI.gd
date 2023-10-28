extends TextureRect

var item_tex0 = preload("res://Assets/ui_test_1.png")
var item_tex1 = preload("res://Assets/Fire_Extinguisher_.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture(item_tex0)
	get_parent().get_parent().item_to_ui.connect(_on_recived_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_recived_item(item):
	set_texture(item.get_node("Sprite2D").texture)
