extends Sprite2D
@onready var bird = $"../../Bird"

func _process(_delta):
	if not bird.dead: position.x -= 2
	if position.x <= -169: position.x = 502
