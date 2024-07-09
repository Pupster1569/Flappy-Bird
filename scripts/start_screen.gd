extends Node2D
@onready var bird = $"../../Bird"
@onready var start_sound = $start_sound

var play_sound: bool = true

func _ready(): z_index = 2

func _process(_delta): 
	if bird.start:
		z_index = -100
		if play_sound:
			start_sound.play()
			play_sound = false
