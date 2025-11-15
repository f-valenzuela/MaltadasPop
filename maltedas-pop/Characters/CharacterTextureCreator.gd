extends Node2D

class_name CharacterTextureCreator

enum BodyParts {Body, Eyes, Hair, Head}

const CHARACTER_TEXTURES : CharacterTextures = preload("uid://bhd4edmem4kh")

func random_textures() -> Array[int]:
	var new_body_texture : int = randi_range(0, CHARACTER_TEXTURES.body_textures.size() - 1)
	var new_eyes_texture : int = randi_range(0, CHARACTER_TEXTURES.eyes_textures.size() - 1)
	var new_hair_texture : int = randi_range(0, CHARACTER_TEXTURES.hair_textures.size() - 1)
	var new_head_texture : int = randi_range(0, CHARACTER_TEXTURES.head_textures.size() - 1)
	
	return [
		new_body_texture, 
		new_eyes_texture, 
		new_hair_texture, 
		new_head_texture
		]

func get_texture(body_part : BodyParts, index : int):
	var new_texture : Texture
	match body_part:
		BodyParts.Body:
			index = normalize_index(CHARACTER_TEXTURES.body_textures, index)
			new_texture = CHARACTER_TEXTURES.body_textures[index]
		BodyParts.Eyes:
			index = normalize_index(CHARACTER_TEXTURES.eyes_textures, index)
			new_texture = CHARACTER_TEXTURES.eyes_textures[index]
		BodyParts.Hair:
			index = normalize_index(CHARACTER_TEXTURES.hair_textures, index)
			new_texture = CHARACTER_TEXTURES.hair_textures[index]
		BodyParts.Head:
			index = normalize_index(CHARACTER_TEXTURES.head_textures, index)
			new_texture = CHARACTER_TEXTURES.head_textures[index]
	
	return new_texture

func normalize_index(textures : Array, index : int) -> int:
	if index < 0:
		index = textures.size() - 1
	elif index >= textures.size():
		index = 0
	
	return index


## unused logi for character customization
#@onready var body_marker: BodyPart = $BodyMarker
#@onready var eyes_marker: BodyPart = $EyesMarker
#@onready var head_marker: BodyPart = $HeadMarker
#@onready var hair_marker: BodyPart = $HairMarker
#
#var current_body_texture : int
#var current_eyes_texture : int
#var current_hair_texture : int
#var current_head_texture : int
#
#func body_texture_selected(new_texture : Texture):
	#body_marker.set_texture(new_texture)
#
#func eyes_texture_selected(new_texture : Texture):
	#eyes_marker.set_texture(new_texture)
#
#func head_texture_selected(new_texture : Texture):
	#head_marker.set_texture(new_texture)
#
#func hair_texture_selected(new_texture : Texture):
	#hair_marker.set_texture(new_texture)








	
