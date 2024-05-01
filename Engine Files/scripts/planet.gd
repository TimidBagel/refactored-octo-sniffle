extends Node

@export var planetName : String
@export var civilizations : Array[civilization] # list
@export var breathable_atmosphere : bool
@export var water_source : bool
@export var resource_harvest_multiplier : float
@export var temperature : String

@onready var ui_element_name : ui_elements = get_node("Control/ui_test")

var america = civilization.new("America", 1000, 100, 100, 100, 100, [], 100)

func _ready() -> void:
	ui_element_name.change_civilization(america)
	print(ui_element_name)
	add_civilization(america)

func add_civilization(new) -> bool:
	civilizations.append(new)
	add_child(new)
	return true

func _process(delta):
	ui_element_name.change_text()
