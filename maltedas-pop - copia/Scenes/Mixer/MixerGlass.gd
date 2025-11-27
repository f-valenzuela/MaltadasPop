@tool
extends Control

class_name MixerGlass

enum Modes {Display, Mixing, Decorating}

const COMPLETE_GLASS_TEXTURES : Array[Texture] = [preload("uid://dg802ovtrvbm0"), preload("uid://dhu5gw6f0ufj5")]
const SIMPLE_GLASS_TEXTURES : Array[Texture] = [preload("uid://j7ftvv37w36s"), preload("uid://doxl0dsdni3gb")]
const GLASS_MASK_TEXTURES : Array[Texture] = [preload("uid://by8gsqnibbuix"), preload("uid://b6pps7covdu0a")]

const DECORATION_TEXTURES : Dictionary = {
	SmoothieData.DecorationTypes.Chocolate: [
		preload("uid://bhvcxn54al486"),
		preload("uid://blxivjor8kjxf"),
		preload("uid://dmyiyk5yebumt"),
	],
	
	SmoothieData.DecorationTypes.Cookie: [
		preload("uid://b41be85dsw11v"),
		preload("uid://ch8xh44h3xpcx"), 
		preload("uid://dpe020cdfdaw0"),
	],
	
	SmoothieData.DecorationTypes.Mani: [
		preload("uid://cm35ok4yvkwi"),
		preload("uid://5b5n0hp746kt"),
		preload("uid://vyi7prbkwnm1"),
	],
	
	SmoothieData.DecorationTypes.Empty: [],}
const DECORATION_LEVEL_ORDER : Array[int] = [1,0,2]

const FLAVOR_TEXTURES : Array[Texture] = [
	preload("uid://bv04eim3x0wq4"), 
	preload("uid://bp3posw2qd2kd"), 
	preload("uid://1ygs426wjrmh"), ]

const SECONDARY_DECO_TEXTURES : Array[Texture] = [preload("uid://dcold2vxjag0s"), preload("uid://bkksmwvvmppoo")]

const TOPPING_TEXTURES : Array[Texture] = [
	preload("uid://bn7hmp4pm5dy1"), 
	preload("uid://crq3o1aiosktu"), 
	preload("uid://lr20v4v0yx0n"), 
	preload("uid://bfv2fikt2p4be"),]

@export_group("Nodes")
@export var progress_bar_node : ProgressBar
@export var deco_texture_node : TextureRect
@export var glass_back_node : TextureRect
@export var glass_mask_node : TextureRect
@export var glass_front_node : TextureRect
@export var ice_cream_node : TextureRect
@export var secondary_flavor_node : TextureRect
@export var topping_node : TextureRect

@onready var clicker_area: Button = $ClickerArea
@onready var mixing_progress_bar: ProgressBar = $MixingProgressBar
@onready var nine_patch_rect: NinePatchRect = $NinePatchRect


@export_group("Debug Tools")
@export var debug_mode : bool = false

@export var debug_glass_type : SmoothieData.GlassType:
	set(value):
		if not debug_mode == true:
			return
		reset()
		debug_glass_type = value
		set_glass_type(value)

@export var debug_decoration : SmoothieData.DecorationTypes :
	set(value):
		if not debug_mode == true:
			return
		debug_decoration = SmoothieData.DecorationTypes.Empty
		set_decoration(value)

@export var debug_flavor : SmoothieData.IceCreamFlavors :
	set(value):
		if not debug_mode == true:
			return
		debug_flavor = value
		set_flavor(value)

@export var debug_secondary_flavor_node : SmoothieData.SecondaryFlavorTypes :
	set(value):
		if not debug_mode == true:
			return
		debug_secondary_flavor_node = value
		set_secondary_flavor(value)

var current_glass_type : SmoothieData.GlassType

var current_decoration : SmoothieData.DecorationTypes
var decoration_level : int

var current_flavor : SmoothieData.IceCreamFlavors

var current_secondary_flavor : SmoothieData.SecondaryFlavorTypes

var current_topping : SmoothieData.ToppingTypes

var is_mixing : bool = false
var is_decorating : bool = false

var mix_value : float = 0
var staling_speed := 0.1
var mixing_speed := 5

var clicked : bool = false

var current_data : SmoothieData

signal finished (data : SmoothieData)

func start(state : Modes, data : SmoothieData):
	current_data = data
	load_data(data)
	if state == Modes.Mixing:
		if data.mixed == false:
			is_mixing = true
			clicker_area.show()
			mixing_progress_bar.show()
			nine_patch_rect.show()
	else:
		clicker_area.hide()
		mixing_progress_bar.hide()
		nine_patch_rect.hide()
	if state == Modes.Decorating:
		is_decorating = true

func _process(delta):
	if not is_mixing:
		return
	
	mix_value -= staling_speed * delta
	
	if clicked:
		mix_value += mixing_speed * delta
		clicked = false
	
	mix_value = clamp(mix_value, 0, 1)
	set_progress(mix_value)

func load_data(data : SmoothieData):
	reset()
	if not data.glass == SmoothieData.GlassType.Empty:
		set_glass_type(data.glass)
		set_progress(data.mix_porcentage)
		decoration_level = data.decoration_amount
		set_decoration(data.decoration)
		set_flavor(data.flavor)
		set_secondary_flavor(data.secondary_flavor)
		set_topping(data.topping)

func set_progress(value : float):
	progress_bar_node.value = value

func set_glass_type(glass : SmoothieData.GlassType):
	reset()
	current_glass_type = glass
	match glass:
		SmoothieData.GlassType.Empty:
			glass_back_node.texture = null
			glass_front_node.texture = null
			glass_mask_node.texture = null
		SmoothieData.GlassType.Simple:
			self.show()
			glass_back_node.texture = SIMPLE_GLASS_TEXTURES[0]
			glass_front_node.texture = SIMPLE_GLASS_TEXTURES[1]
			glass_mask_node.texture = GLASS_MASK_TEXTURES[1]
		SmoothieData.GlassType.Complete:
			self.show()
			glass_back_node.texture = COMPLETE_GLASS_TEXTURES[0]
			glass_front_node.texture = COMPLETE_GLASS_TEXTURES[1]
			glass_mask_node.texture = GLASS_MASK_TEXTURES[0]

func set_decoration(decoration : SmoothieData.DecorationTypes):
	if current_glass_type != SmoothieData.GlassType.Complete:
		return
	
	if decoration == SmoothieData.DecorationTypes.Empty:
		deco_texture_node.texture = null
		current_decoration = SmoothieData.DecorationTypes.Empty
		decoration_level = 0
		return
	
	if decoration == current_decoration:
		decoration_level = clamp(decoration_level + 1, 0, 2)
	else:
		current_decoration = decoration
		decoration_level = 0
	
	var list : Array = DECORATION_TEXTURES.get(current_decoration)
	
	if list.size() == 0:
		deco_texture_node.texture = null
		return
	
	var index := DECORATION_LEVEL_ORDER[decoration_level]
	
	deco_texture_node.texture = list[index]

func set_flavor(flavor : SmoothieData.IceCreamFlavors):
	if current_glass_type == SmoothieData.GlassType.Empty:
		ice_cream_node.texture = null
		current_flavor = SmoothieData.IceCreamFlavors.Empty
		return
	
	match flavor:
		SmoothieData.IceCreamFlavors.Empty:
			ice_cream_node.texture = null
		SmoothieData.IceCreamFlavors.Chocolate:
			ice_cream_node.texture = FLAVOR_TEXTURES[0]
		SmoothieData.IceCreamFlavors.Dulce:
			ice_cream_node.texture = FLAVOR_TEXTURES[1]
		SmoothieData.IceCreamFlavors.Vanilla:
			ice_cream_node.texture = FLAVOR_TEXTURES[2]
	
	current_flavor = flavor

func set_secondary_flavor(flavor : SmoothieData.SecondaryFlavorTypes):
	if current_glass_type == SmoothieData.GlassType.Empty:
		secondary_flavor_node.texture = null
		current_secondary_flavor = SmoothieData.SecondaryFlavorTypes.Empty
		return
	
	match flavor:
		SmoothieData.SecondaryFlavorTypes.Empty:
			secondary_flavor_node.texture = null
		SmoothieData.SecondaryFlavorTypes.Chocolate:
			secondary_flavor_node.texture = SECONDARY_DECO_TEXTURES[0]
		SmoothieData.SecondaryFlavorTypes.Dulce:
			secondary_flavor_node.texture = SECONDARY_DECO_TEXTURES[1]
	
	current_secondary_flavor = flavor

func set_topping(topping : SmoothieData.ToppingTypes):
	match topping:
		SmoothieData.ToppingTypes.Empty:
			topping_node.texture = null
		SmoothieData.ToppingTypes.Cake:
			topping_node.texture = TOPPING_TEXTURES[1]
		SmoothieData.ToppingTypes.Brownie:
			topping_node.texture = TOPPING_TEXTURES[0]
		SmoothieData.ToppingTypes.Cookie:
			topping_node.texture = TOPPING_TEXTURES[2]
			topping_node.texture = null
		SmoothieData.ToppingTypes.Oreo:
			topping_node.texture = TOPPING_TEXTURES[3]
			topping_node.texture = null
	
	current_topping = topping

func reset():
	current_glass_type = SmoothieData.GlassType.Empty
	glass_back_node.texture = null
	glass_front_node.texture = null
	glass_mask_node.texture = null
	
	set_decoration(SmoothieData.DecorationTypes.Empty)
	set_flavor(SmoothieData.IceCreamFlavors.Empty)
	set_secondary_flavor(SmoothieData.SecondaryFlavorTypes.Empty)
	set_topping(SmoothieData.ToppingTypes.Empty)
	set_progress(0)

func _on_clicker_area_pressed() -> void:
	if is_mixing:
		clicked = true

func _on_complete_button_pressed() -> void:
	is_mixing = false
	
	current_data.glass = current_glass_type
	current_data.mix_porcentage = mix_value
	current_data.decoration = current_decoration
	current_data.decoration_amount = decoration_level
	current_data.flavor = current_flavor
	current_data.secondary_flavor = current_secondary_flavor
	current_data.topping = current_topping
	current_data.mixed = true
	
	finished.emit(current_data)
