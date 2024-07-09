extends Area2D
@onready var timer = $Timer
var dead: bool = false

func _ready():
	dead = false
	
func _process(_delta):
	if dead: if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("click"): get_tree().reload_current_scene()

func _on_body_entered(_body):
	dead = true
	timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
