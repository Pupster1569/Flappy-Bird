extends Area2D
@onready var floor_kill = $"../../floorKill"
@onready var timer = $Timer
@onready var pipe2 = $"../Pipe2"
@onready var pipe = $"../Pipe"
@onready var bird = $"../../Bird"
@onready var floor_kill_2 = $"../../floorKill2"

var dead: bool = false
var scored: bool = false

func _process(_delta):
	if floor_kill.dead or floor_kill_2.dead: dead = true
	if pipe2.dead: dead = true
	if pipe.dead: dead = true
	if dead: if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("click"): get_tree().reload_current_scene()
	if bird.start:
		if not dead: position.x -= 2
		
		if position.x <= -30:
			position.y = randi_range(400,570)
			position.x = 361

func _on_body_entered(_body):
	dead = true
	timer.start()
	
func _on_timer_timeout():
	get_tree().reload_current_scene()

func _on_score_detection_body_entered(_body): scored = true
func _on_score_detection_body_exited(_body): scored = false
