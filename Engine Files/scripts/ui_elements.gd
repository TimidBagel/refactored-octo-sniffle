extends Control
class_name ui_elements

var focused_planet : Planet
var focused_civilization : civilization

@onready var c_name : Label = $"../CivInfo/CivName"
@onready var c_pop : Label = $"../CivInfo/CivPop"
@onready var c_food : Label = $"../CivInfo/CivFood"
@onready var c_water : Label = $"../CivInfo/CivWater"
@onready var c_oxy : Label = $"../CivInfo/CivOxy"
@onready var c_fuel : Label = $"../CivInfo/CivFuel"
@onready var c_resources : Label = $"../CivInfo/CivResources"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_planet(net):
	focused_planet = net

func change_pop_text():
	c_pop.set_text("Population: "+str(focused_civilization.population))

func change_food_text():
	c_food.set_text("Food: "+str(focused_civilization.food_count))

func change_water_text():
	c_water.set_text("Water: "+str(focused_civilization.water_count))

func change_oxy_text():
	c_oxy.set_text("Oxygen: "+str(focused_civilization.oxygen_count))

func change_all_text():
	c_name.set_text(str(focused_civilization.civ_name))
	c_pop.set_text("Population: "+str(focused_civilization.population))
	c_food.set_text("Food: "+str(focused_civilization.food_count))
	c_water.set_text("Water: "+str(focused_civilization.water_count))
	c_oxy.set_text("Oxygen: "+str(focused_civilization.oxygen_count))
	c_fuel.set_text("Fuel: "+str(focused_civilization.fuel_count))
	c_resources.set_text("Resources: "+str(focused_civilization.resources))
	
func change_civilization(civ):
	focused_civilization = civ
	focused_civilization.population_changed.connect(change_pop_text)
	focused_civilization.oxygen_changed.connect(change_oxy_text)
	focused_civilization.water_changed.connect(change_water_text)
	focused_civilization.food_changed.connect(change_food_text)

func reset_all_text():
	c_name.set_text("")
	c_pop.set_text("")
	c_food.set_text("")
	c_water.set_text("")
	c_oxy.set_text("")
	c_fuel.set_text("")
	c_resources.set_text("")
	
	focused_civilization.population_changed.disconnect(change_pop_text)
	focused_civilization.oxygen_changed.disconnect(change_oxy_text)
	focused_civilization.water_changed.disconnect(change_water_text)
	focused_civilization.food_changed.disconnect(change_food_text)
