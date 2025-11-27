extends Control

class_name CharacterTextureCreator

enum BodyParts {Body, Face, Brows, EyesBack, Iris, Eyes, Mouth, Nose, Hair}

@onready var body: TextureRect = $Body
@onready var face: TextureRect = $Face
@onready var brows: TextureRect = $Brows
@onready var eyes_back: TextureRect = $EyesBack
@onready var iris: TextureRect = $Iris
@onready var eyes: TextureRect = $Eyes
@onready var mouth: TextureRect = $Mouth
@onready var nose: TextureRect = $Nose
@onready var hair: TextureRect = $Hair

@export var character_textures : CharacterTextures

func _ready() -> void:
	randomize_textures()

func randomize_textures():
	body.texture = character_textures.body_textures.pick_random()
	face.texture = character_textures.face_textures.pick_random()
	brows.texture = character_textures.brows_textures.pick_random()
	eyes_back.texture = character_textures.eyes_back_textures.pick_random()
	iris.texture = character_textures.iris_textures.pick_random()
	eyes.texture = character_textures.eyes_front_textures.pick_random()
	mouth.texture = character_textures.mouth_textures.pick_random()
	nose.texture = character_textures.nose_textures.pick_random()
	hair.texture = character_textures.hair_textures.pick_random()
	
	body.modulate = Color(randf(),randf(), randf())

















	
