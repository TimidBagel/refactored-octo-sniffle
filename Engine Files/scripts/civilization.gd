class civilization : extends Node

var population
var fuel_count
var oxygen_count
var food_count
var water_count
var building_list = []

var pop_growth_multiplier
var pop_decline_multiplier

# Called when the node enters the scene tree for the first time.
func _ready(init_pop, init_fuel, init_oxygen, init_food, init_water, init_buildings, growth, decline):
	self.population = init_pop
	self.fuel_count = init_fuel
	self.oxygen_count = init_oxygen
	self.food_count = init_food
	self.water_count = init_water
	self.building_list = init_buildings
	
	self.pop_growth_multiplier = growth
	self.pop_decline_multiplier = decline
	
	pass # Replace with function body.

func passive_resource_consumption():
	self.oxygen_count -= self.population * 2.2 # eventually replace hardcoded numbers with a variable that can be tweaked
	self.water_count -= self.population * 2.5 # im thinking that different civilizations will require different needs, an alien species can require less water than humans, just an idea though
	self.food_count -= self.population * 2
	self.fuel_count -= self.population * 1.5 # placeholder, i dont really know how much you want fuel to drain each cycle
	

func population_growth_decline():
	self.population -= int(self.population / self.pop_decline_multiplier) # placeholder replace with an actual value to subtract the population by, ideally it will be casted to an integer
	self.population += int(self.population * self.pop_growth_multiplier)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
