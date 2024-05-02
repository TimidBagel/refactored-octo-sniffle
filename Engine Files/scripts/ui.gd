extends CanvasLayer

class_name UI

@onready var planet_name = $Control/ColorRect/Name
@onready var population_count = $Control/ColorRect/PopulationCount
@onready var water_source = $"Control/ColorRect/WaterSource?"
@onready var breatheable = $"Control/ColorRect/Breathable?"
@onready var planet_image = $Control/ColorRect/ImageContainer/PlanetImage

@onready var civ_list : ItemList = $Control/ColorRect/CivList
@onready var civ_info : ui_elements = $Control/ColorRect/ui_elements


var current_planet : planet

func set_planet(planet_ : planet):
	current_planet = planet_
	planet_name.set_text(str(planet_.planet_name))
	population_count.set_text("Population: " + str(planet_.total_population))
	var water_bool
	if planet_.water_source: water_bool = "YES"
	else: water_bool = "NO"
	var breathe_bool
	if planet_.breathable_atmosphere: breathe_bool = "YES"
	else: breathe_bool = "NO" 
	water_source.set_text("Water Source: " + water_bool)
	breatheable.set_text("Breatheable: " + breathe_bool)
	planet_image.sprite_frames = planet_.sprite_frames
	planet_image.play("rotate")
	
	civ_info.change_planet(current_planet)
	
	for i in current_planet.civilizations:
		civ_list.add_item(str(i.civ_name))


func _on_button_pressed():
	civ_list.clear()
	self.visible = false


func _on_civ_list_item_activated(index):
	civ_info.change_civilization(current_planet.civilizations[index])
	civ_info.change_text()
 
func _on_back_button_pressed():
	self.visible = false

func _on_add_civ_button_pressed():
	current_planet.add_civilization(civilization.new(
		"America",
		100000,
		50000,
		1000,
		10000000,
		10000000,
		[],
		10000
	))
