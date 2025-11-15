extends Marker2D

class_name BodyPart

@export var sprite : Sprite2D
@export var mirror_sprite : Sprite2D

func _ready() -> void:
	if mirror_sprite:
		mirror_sprite.scale.x = mirror_sprite.scale.x * -1

func set_texture(new_texture : Texture):
	sprite.texture = new_texture
	if mirror_sprite:
		mirror_sprite.texture = new_texture
