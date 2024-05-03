# Class which details the attributes and functionality of a Civilization
class_name Civilization extends Node

# signals which communicate that various values have been altered
signal population_changed
signal food_changed
signal water_changed
signal oxygen_changed
signal res_changed
signal fuel_changed

# civilization specific attributes
var civ_name
var population
var fuel_count
var oxygen_count
var food_count
var water_count
var resources
var building_list : Array[Building]
var parent_planet : Planet

# this is a factor multiplied with the population value
var pop_growth_rate = 0.00000127

# measured in kilograms per day
@onready var oxygen_decrease_rate = 2.2
@onready var water_decrease_rate = 2.5
@onready var food_decrease_rate = 2.0

var tick = 0

# constructor which initializes a new Civilization class and sets various parameters. 
func _init(parent_planet_, c_name, pop = 0, fuel = 0, oxygen = 0, food = 0, water = 0, buildings : Array[Building] = [], res = 0, oxygen_decline = 2.2, water_decline = 2.5, food_decline = 2.0,):
	self.parent_planet = parent_planet_
	self.civ_name = c_name
	self.population = pop
	self.fuel_count = fuel
	self.oxygen_count = oxygen
	self.food_count = food
	self.water_count = water
	self.resources = res
	self.building_list = buildings
	
	self.oxygen_decrease_rate = oxygen_decline
	self.water_decrease_rate = water_decline
	self.food_decrease_rate = food_decline
	
	pass

# consumes oxygen, water, and food based on their usage rates
func passive_civilization_consumption():
	change_oxygen(population * -oxygen_decrease_rate)
	change_water(population * -water_decrease_rate)
	change_food(population * -food_decrease_rate)
	
# alters oxygen value by 'amt' and emits the 'oxygen_changed' signal
func change_oxygen(amt):
	oxygen_count += amt
	oxygen_changed.emit()

# alters water value by 'amt' and emits the 'water_changed' signal
func change_water(amt):
	water_count += amt
	water_changed.emit()

# alters food value by 'amt' and emits the 'food_changed' signal
func change_food(amt):
	food_count += amt
	food_changed.emit()

# alters population value by 'amt' and emits the 'population_changed' signal
func change_population(amt):
	population += amt
	population_changed.emit()

# alters fuel value by 'amt' and emits the 'fuel_changed' signal
func change_fuel(amt):
	fuel_count += amt
	fuel_changed.emit()

# alters resource value by 'amt' and emits the 'res_changed' signal
func change_resource(amt):
	resources += amt
	res_changed.emit()

# increases population by set rate
func population_growth():
	change_population(population * pop_growth_rate)

var time = 0

# tick function, runs timer-based logic on a per-second basis
func _process(delta):
	time += delta
	if (time >= 1):
		passive_civilization_consumption()
		population_growth()
		#print_details()
		time = 0
	
# debug function which displays civilization information
func print_details():
	print("population - %d\nfood - %d\nwater - %d\noxygen - %d\nfuel - %d" % [population, food_count, water_count, oxygen_count, fuel_count])

# sends people to a target civilization
func transfer_people(num, destination):
	population -= num
	destination.population += num

# sends food to a target civilization
func transfer_food(num, destination):
	food_count -= num
	destination.food_count += num

# sends water to a target civilization
func transfer_water(num, destination):
	water_count -= num
	destination.water_count += num

# sends oxygen to a target civilization
func transfer_oxygen(num, destination):
	oxygen_count -= num
	destination.oxygen_count += num

# sends fuel to a target civilization
func transfer_fuel(num, destination):
	fuel_count -= num
	destination.fuel_count += num

# sends resources to a target civilization
func transfer_resource(num, destination):
	resources -= num
	destination.resources += num
