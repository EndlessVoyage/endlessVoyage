extends CharacterBody2D

@export var speed = 700
var screen_size
var starting_animation = true
var gotFireExtinguisher = false

signal do_action(asset_type: String, args)

func _ready():
	# Size of area always size of player collision
	var player_transform = $CollisionShape2D.transform
	$Area2D/CollisionShape2D.transform = player_transform
	screen_size = Vector2(3840,1080)
	$AnimatedSprite2D.play("standing_up")

func _process(delta):
	var newVelocity = Vector2.ZERO

	if Input.is_action_just_pressed("ui_accept"):		
		for body in $Area2D.get_overlapping_bodies():
			handle_action(body)
			if body.name == "Generator" and gotFireExtinguisher:
				extinguish()

	if $AnimatedSprite2D.frame == 10:
		starting_animation = false	
	if starting_animation == false:

		if Input.is_action_pressed("ui_right"):
			newVelocity.x += 1
		if Input.is_action_pressed("ui_left"):
			newVelocity.x -= 1

		if newVelocity.length() > 0:
			newVelocity = newVelocity.normalized() * speed
		
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

func _on_area_2d_body_entered(body):
	handle_action(body)

func handle_action(body: Node2D):
	var asset_type = ""
	var args = []
	if "ASSET_TYPE" in body:
		asset_type = body["ASSET_TYPE"]
	if "ARGS" in body:
		args = body["ARGS"]
	print(body.name)
	if asset_type == "" or args == []:
		return
	if asset_type == "Killing_Object":
		get_tree().reload_current_scene()
		
	if args:
		if asset_type == "item":
			if args[1] == "extinguish":
				gotFireExtinguisher = true

	do_action.emit(asset_type, args)

func extinguish():
	$AnimatedSprite2D.visible = false
	$PlayerHolding.visible = true
	$FireE.visible = true
	$foam.visible = true
