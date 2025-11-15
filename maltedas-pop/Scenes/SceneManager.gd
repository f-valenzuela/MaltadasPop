extends Node

class_name SceneManager

enum Scenes {Counter, Mixer, Topping}

@onready var counter_scene: Scene = $CounterScene
@onready var mixer_scene: Scene = $MixerScene
@onready var topping_scene: Scene = $ToppingScene

@export var camera : Camera2D

var current_scene : Scenes = Scenes.Counter

signal scene_changed(scene : Scenes)

func _ready() -> void:
	for child in get_children():
		if child is Scene:
			child.set_camera(camera)

func _on_scene_changed(new_scene: Scenes) -> void:
	if new_scene == current_scene:
		pass
	else:
		current_scene = new_scene
		scene_changed.emit(new_scene)
	
