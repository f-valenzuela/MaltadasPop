extends Scene

class_name CounterScene
const CHARACTER_TEXTURE_CREATOR = preload("uid://c5e8fgf5smace")

var humans : Array

@onready var humans_container: Control = $HumansContainer

func create_human():
	var new_human : CharacterTextureCreator = CHARACTER_TEXTURE_CREATOR.instantiate()
	humans_container.add_child(new_human)
	new_human.randomize_textures()
	new_human.position = Vector2(randf_range(0, 500), 800)
	new_human.scale = Vector2(0.5, 0.5)

func destroy_human():
	humans.pop_front()
	humans_container.get_child(0).queue_free()
