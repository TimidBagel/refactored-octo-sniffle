# Class which contains the logic and elements of the User Interface
class_name UI extends CanvasLayer

@onready var planet_name = $Control/ColorRect/Name
@onready var population_count = $Control/ColorRect/PlanetInfoContainer/PopulationCount
@onready var water_source = $"Control/ColorRect/PlanetInfoContainer/WaterSource?"
@onready var breatheable = $"Control/ColorRect/PlanetInfoContainer/Breathable?"
@onready var planetimage = $Control/ColorRect/PlanetImageContainer/PlanetImage

@onready var civ_list : ItemList = $Control/ColorRect/CivList
@onready var civ_info_box = $Control/ColorRect/CivInfoBox

@onready var c_name = $Control/ColorRect/CivInfoBox/CivInfo/CivName
@onready var c_pop = $Control/ColorRect/CivInfoBox/CivInfo/CivPop
@onready var c_food = $Control/ColorRect/CivInfoBox/CivInfo/CivFood
@onready var c_water = $Control/ColorRect/CivInfoBox/CivInfo/CivWater
@onready var c_oxy = $Control/ColorRect/CivInfoBox/CivInfo/CivOxy
@onready var c_fuel = $Control/ColorRect/CivInfoBox/CivInfo/CivFuel
@onready var c_resources = $Control/ColorRect/CivInfoBox/CivInfo/CivResources

var current_planet : Planet
var current_civilization : Civilization

func set_planet(planet : Planet):
	current_planet = planet
	planet_name.set_text(str(planet.planet_name))
	population_count.set_text("Population: " + str(planet.total_population))
	var water_bool
	if planet.water_source: water_bool = "YES"
	else: water_bool = "NO"
	var breathe_bool
	if planet.breathable_atmosphere: breathe_bool = "YES"
	else: breathe_bool = "NO" 
	water_source.set_text("Water Source: " + water_bool)
	breatheable.set_text("Breatheable: " + breathe_bool)
	planetimage.sprite_frames = planet.sprite_frames
	planetimage.play("rotate")
	
	for i in current_planet.civilizations:
		civ_list.add_item(str(i.civ_name))
	

func _on_civ_list_item_activated(index):
	set_civilization(current_planet.civilizations[index])
	set_all_text()
 
func _on_back_button_pressed():
	if current_civilization != null:
		reset_all_text()
	civ_list.clear()
	current_civilization = null
	current_planet = null
	self.visible = false
	civ_info_box.visible = false

func _on_add_civ_button_pressed():
	current_planet.add_civilization(Civilization.new(
		current_planet,
		"America",
		100000,
		50000,
		1000,
		10000000,
		10000000,
		[],
		10000
	))

func set_pop_text():
	c_pop.set_text("Population: %s" % truncate_number(current_civilization.population))

func set_food_text():
	c_food.set_text("Food: %s kg" % truncate_number(current_civilization.food_count))

func set_water_text():
	c_water.set_text("Water: %s kg" % truncate_number(current_civilization.water_count))

func set_oxy_text():
	c_oxy.set_text("Oxygen: %s kg" % truncate_number(current_civilization.oxygen_count))

func set_fuel_text():
	c_fuel.set_text("Fuel: %s kg" % truncate_number(current_civilization.fuel_count))

func set_res_text():
	c_resources.set_text("Resources: %s kg" % truncate_number(current_civilization.resources))

func set_all_text():
	c_name.set_text(str(current_civilization.civ_name))
	c_pop.set_text("Population: %s" % truncate_number(current_civilization.population))
	c_food.set_text("Food: %s kg" % truncate_number(current_civilization.food_count))
	c_water.set_text("Water: %s kg" % truncate_number(current_civilization.water_count))
	c_oxy.set_text("Oxygen: %s kg" % truncate_number(current_civilization.oxygen_count))
	c_fuel.set_text("Fuel: %s kg" % truncate_number(current_civilization.fuel_count))
	c_fuel.set_text("Fuel: %s kg" % truncate_number(current_civilization.fuel_count))
	c_resources.set_text("Resources: %s kg" % truncate_number(current_civilization.resources))
	
func set_civilization(civ):
	if current_civilization && current_civilization.is_connected("food_changed", set_food_text):
		disconnect_all_signals()
	current_civilization = civ
	civ_info_box.visible = true
	current_civilization.population_changed.connect(set_pop_text)
	current_civilization.oxygen_changed.connect(set_oxy_text)
	current_civilization.water_changed.connect(set_water_text)
	current_civilization.food_changed.connect(set_food_text)
	current_civilization.fuel_changed.connect(set_fuel_text)
	current_civilization.res_changed.connect(set_res_text)

func reset_all_text():
	c_name.set_text("")
	c_pop.set_text("")
	c_food.set_text("")
	c_water.set_text("")
	c_oxy.set_text("")
	c_fuel.set_text("")
	c_resources.set_text("")
	
	disconnect_all_signals()
	
func disconnect_all_signals():
	current_civilization.population_changed.disconnect(set_pop_text)
	current_civilization.oxygen_changed.disconnect(set_oxy_text)
	current_civilization.water_changed.disconnect(set_water_text)
	current_civilization.food_changed.disconnect(set_food_text)
	current_civilization.fuel_changed.disconnect(set_fuel_text)
	current_civilization.res_changed.disconnect(set_res_text)

# truncates a value and adds a suffix for better readability
func truncate_number(num):
	var magnitude_suffixes = ['', 'K', 'M', 'B', 'T']  # Suffixes for thousand, million, billion, trillion
	var magnitude = 0

	while abs(num) >= 1000 and magnitude < len(magnitude_suffixes) - 1:
		magnitude += 1
		num /= 1000
	var suffix = magnitude_suffixes[magnitude]
	return '{num}{mag}'.format([["num", int(num)], ["mag", suffix]])
