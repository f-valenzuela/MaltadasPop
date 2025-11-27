@tool
extends Button

class_name GlassButton

const COMPLETE_GLASSES_BUTTON = preload("uid://b33l6tm0ay64t")
const SIMPLE_GLASSES_BUTTON = preload("uid://c5qrgnqq6trc7")

@export var texture_rect: TextureRect

@export var debug_mode : bool = false

@export var glass_type : SmoothieData.GlassType 
	#set(value):
		#glass_type = value
		#if  debug_mode == false:
			#return
		#set_texture(value)

signal glass_selected (type : SmoothieData.GlassType)

func _ready() -> void:
	set_texture(glass_type)

func set_texture(type : SmoothieData.GlassType):
	if type == SmoothieData.GlassType.Empty:
		texture_rect.texture = null
	if type == SmoothieData.GlassType.Simple:
		texture_rect.texture = SIMPLE_GLASSES_BUTTON
	if type == SmoothieData.GlassType.Complete:
		texture_rect.texture = COMPLETE_GLASSES_BUTTON

func _on_pressed() -> void:
	glass_selected.emit(glass_type)
