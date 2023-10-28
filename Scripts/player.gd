extends CharacterBody2D

@export var speed = 400
var screen_size

func _ready():
	# Size of area always size of player collision
	var player_transform = $CollisionShape2D.transform
	$Area2D/CollisionShape2D.transform = player_transform
	screen_size = Vector2(1920,1080)

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
	else:
		$AnimatedSprite2D.animation = "idle"
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_area_2d_body_entered(body):
	print(body.has_method("asset_type"))
	if "asset_type" in body:
		print("Hat das Attribut")
