extends StaticBody2D

@export var state = "unsolved"
@export var ASSET_TYPE = "puzzle"
@export var ARGS = [null] # The action required to solve the puzzle
const solution = "extinguish"

# Called when the node enters the scene tree for the first time.
func _ready():
	ARGS[0] = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func process_puzzle_solution(action: String):
	return action == solution
