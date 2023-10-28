extends CharacterBody2D

@export var speed = 700
var screen_size

func _ready():
	# Size of area always size of player collision
	var player_transform = $CollisionShape2D.transform
	$Area2D/CollisionShape2D.transform = player_transform
	screen_size = Vector2(3840,1080)

func _process(delta):
	var newVelocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		$PointLight2D.position.x = 2000
		$PointLight2D.position.y = -100
		newVelocity.x += 1
	if Input.is_action_pressed("left"):
		$PointLight2D.position.x = -2200
		$PointLight2D.position.y = -100
		newVelocity.x -= 1
	if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		$PointLight2D.position.x = 0
		$PointLight2D.position.y = 300

	if newVelocity.length() > 0:
		newVelocity = newVelocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += newVelocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if newVelocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
	else:
		$AnimatedSprite2D.animation = "idle"
	
	if newVelocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
	if $AnimatedSprite2D.is_playing() and !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
	elif !$AnimatedSprite2D.is_playing() and $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.stop()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

signal picked_up(item)

func _on_area_2d_body_entered(body):
	if "asset_type" in body:
		if body.has_node("Sprite2D"):
			picked_up.emit(body)
