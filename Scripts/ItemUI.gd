extends TextureRect

var item_tex1 = preload("res://Assets/Fire_Extinguisher_.png")
var item_tex2 = preload("res://Assets/ui_test_1.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_parent().item_to_ui.connect(_on_recived_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_recived_item(item):
	if item == 1:
		set_texture(item_tex2)
