extends Node

class_name SceneManager

enum Scenes {Counter, Mixer, Topping}

@export var camera : Camera2D
@export var Scenes_ui : ScenesUI

var current_scene : Scenes = Scenes.Counter

signal scene_changed(scene : Scenes)

func _on_scene_changed(new_scene: Scenes) -> void:
	print("SceneManager : old scene == ", current_scene)
	print("SceneManager : new scene == ", new_scene)
	if new_scene == current_scene:
		pass
	else:
		match new_scene:
			Scenes.Counter:
				camera.position.y = 1920 * 0
			Scenes.Mixer:
				camera.position.y = 1920 * 1
			Scenes.Topping:
				camera.position.y = 1920 * 2
		
		current_scene = new_scene
		scene_changed.emit(new_scene)
		
