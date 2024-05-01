extends Node

@export var planetName : String
@export var civilizations : Array[civilization] # list
@export var breathable_atmosphere : bool
@export var water_source : bool
@export var resource_harvest_multiplier : float
@export var temperature : String

func _ready() -> void:
	var america = civilization.new(100, 100, 100, 100, 100, [], 100)
	add_civilization(america)

func add_civilization(new) -> bool:
	civilizations.append(new)
	add_child(new)
	return true
