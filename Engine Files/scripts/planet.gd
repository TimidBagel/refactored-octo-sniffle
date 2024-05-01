extends Node

@export var planetName : String
@export var civilizations : Array[civilization] # list
@export var breathable_atmosphere : bool
@export var water_source : bool
@export var resource_harvest_multiplier : float
@export var temperature : String

@onready var ui_element_name : Label = get_node("Control/ui_test")

var america = civilization.new(100, 100, 100, 100, 100, [], 100)

func _ready() -> void:
	#ui_element_name.size = Vector2(10, 15)
	add_civilization(america)

func add_civilization(new) -> bool:
	civilizations.append(new)
	add_child(new)
	return true

func _process(delta):
	ui_element_name.set_text("Food count: "+str(america.food_count)+"\n"+"Oxygen count: "+str(america.oxygen_count)+"\n"+
	"Water count: "+str(america.water_count)+"\n")
