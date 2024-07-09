extends CharacterBody2D
@onready var pipe = $"../pipes/Pipe"
@onready var pipe2 = $"../pipes/Pipe2"
@onready var floor_kill = $"../floorKill"
@onready var wing_sound = $wing_sound
@onready var death_sound = $death_sound
@onready var pipe_death_sound = $pipe_death_sound
@onready var scored_sound = $scored_sound
@onready var score_display = $"../Score"
@onready var floor_kill_2 = $"../floorKill2"
@onready var flap_anim = $flap_anim

var file_path = "user://high_score.txt"
const JUMP_VELOCITY = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var score = 0
var high_score = 0
var count: int = 0

var dead: bool = false
var start: bool = false
var play_sound: bool = true
var increment_score: bool = true

func save(content):
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(content)

func sum(accum: int, element: int) -> int:
	return accum + element

func _ready():
	if !FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.WRITE)
		file.store_string("0")
		file.close()
	var high_score_file = FileAccess.open(file_path, FileAccess.READ)
	high_score = int(high_score_file.get_as_text())

func _process(_delta):
	if not start:
		z_index = -100
		score_display.updateScore(high_score)
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("click"):
			start = true
			z_index = 1
			velocity.y = JUMP_VELOCITY
			score_display.updateScore(0)
	
	if dead and play_sound:
		flap_anim.stop()
		death_sound.play()
		play_sound = false
	
	if pipe.scored or pipe2.scored:
		if increment_score:
			score += 1
			scored_sound.play()
			score_display.updateScore(score)
			increment_score = false
	elif not pipe.scored: increment_score = true
	
	if floor_kill.dead or floor_kill_2.dead: dead = true
	elif pipe.dead: dead = true
	else: dead = false

func _physics_process(delta):
	if start:
		if not dead: 
			velocity.y += gravity*delta
			rotation_degrees = (abs(velocity.y)/8)-30
		else:
			if score > high_score: save(str(score))
			if position.y > 500: position.y = 500
			velocity.y = 0
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("click"):
			if not dead:
				velocity.y = JUMP_VELOCITY
				wing_sound.play()
		move_and_slide()
