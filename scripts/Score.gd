extends HBoxContainer

@onready var score = $"."
var path = "res://assets/sprites/digits/"

func updateScore(_newScore):
	for child in score.get_children():
		child.queue_free()
	for i in str(_newScore):
		var number = TextureRect.new()
		score.add_child(number)
		number.size = Vector2(100,100)
		number.texture = load(path + i + '.png')
