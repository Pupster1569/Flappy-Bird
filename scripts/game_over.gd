extends Sprite2D
@onready var bird = $"../../Bird"

func _ready(): z_index = -100

func _process(_delta): if bird.dead: z_index = 2
