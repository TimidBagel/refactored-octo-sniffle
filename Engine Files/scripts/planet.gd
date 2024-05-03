# Class which details the attributes and functionality of a Planet
class_name Planet extends Node2D

# unique reference to the User Interface within the scene
@onready var ui = %UI

# planet specific attributes
@export var planet_name : String
@export var civilizations : Array[Civilization] # list
@export var breathable_atmosphere : bool
@export var water_source : bool
@export var resource_harvest_multiplier : float
@export var temperature : String
@export var total_population : int
@export var sprite_frames : SpriteFrames

#@onready var ui_element_name : ui_elements = get_node("Control/ui_test")

# debug civilizations
var america = Civilization.new(self, "America", 1000, 100, 100, 100, 100, [], 100)
var hell = Civilization.new(self, "Hell", 1000, 100, 100, 100, 100, [], 100)

# more debug
func _ready() -> void:
	#ui_element_name.change_civilization(america)
	#print(ui_element_name)
	add_civilization(america)
	add_civilization(hell)

# adds 'new' civilization to the planet's list of civilizations
func add_civilization(new) -> bool:
	civilizations.append(new)
	new.population_changed.connect(update_total_population)
	add_child(new)
	return true
	
# removes 'to_remove' civilization from the planet's list of civilizations. returns false if unsuccessful
func remove_civilization(to_remove) -> bool:
	if to_remove in civilizations:
		civilizations.erase(to_remove)
		return true
	else:
		printerr(to_remove.civ_name + " not found in civilization list")
		return false
		
# updates the planet's total population count by checking the population of all of it's child civilizations
func update_total_population():
	var count = 0
	for civ in civilizations:
		count += int(civ.population)
	total_population = count

# called when the planet's collider is clicked
func _on_click_area_input_event(event):
	if (event.is_pressed()):
		print("clicked " + planet_name)
		ui.set_planet(self)
		ui.visible = true
