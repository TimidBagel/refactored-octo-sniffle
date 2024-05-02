extends CanvasLayer

class_name UI

@onready var planet_name = $Control/ColorRect/Name
@onready var population_count = $Control/ColorRect/PopulationCount
@onready var water_source = $"Control/ColorRect/WaterSource?"
@onready var breatheable = $"Control/ColorRect/Breathable?"
@onready var planetimage = $Control/ColorRect/ImageContainer/PlanetImage

@onready var civ_list : ItemList = $Control/ColorRect/CivList

@onready var c_name = $Control/ColorRect/CivInfo/CivName
@onready var c_pop = $Control/ColorRect/CivInfo/CivPop
@onready var c_food = $Control/ColorRect/CivInfo/CivFood
@onready var c_water = $Control/ColorRect/CivInfo/CivWater
@onready var c_oxy = $Control/ColorRect/CivInfo/CivOxy
@onready var c_fuel = $Control/ColorRect/CivInfo/CivFuel
@onready var c_resources = $Control/ColorRect/CivInfo/CivResources

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

func _on_add_civ_button_pressed():
	current_planet.add_civilization(Civilization.new(
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
	c_pop.set_text("Population: %.2f" % current_civilization.population)

func set_food_text():
	c_food.set_text("Food: %.2f" % current_civilization.food_count)

func set_water_text():
	c_water.set_text("Water: %.2f" % current_civilization.water_count)

func set_oxy_text():
	c_oxy.set_text("Oxygen: %.2f" % current_civilization.oxygen_count)

func set_fuel_text():
	c_fuel.set_text("Fuel: %.2f" % current_civilization.fuel_count)

func set_res_text():
	c_resources.set_text("Resources: %.2f" % current_civilization.resources)

func set_all_text():
	c_name.set_text(str(current_civilization.civ_name))
	c_pop.set_text("Population: %.2f" % current_civilization.population)
	c_food.set_text("Food: %.2f" % current_civilization.food_count)
	c_water.set_text("Water: %.2f" % current_civilization.water_count)
	c_oxy.set_text("Oxygen: %.2f" % current_civilization.oxygen_count)
	c_fuel.set_text("Fuel: %.2f" % current_civilization.fuel_count)
	c_fuel.set_text("Fuel: %.2f" % current_civilization.fuel_count)
	c_resources.set_text("Resources: %.2f" % current_civilization.resources)
	
func set_civilization(civ):
	current_civilization = civ
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
	
	current_civilization.population_changed.disconnect(set_pop_text)
	current_civilization.oxygen_changed.disconnect(set_oxy_text)
	current_civilization.water_changed.disconnect(set_water_text)
	current_civilization.food_changed.disconnect(set_food_text)
	current_civilization.fuel_changed.disconnect(set_fuel_text)
	current_civilization.res_changed.disconnect(set_res_text)
