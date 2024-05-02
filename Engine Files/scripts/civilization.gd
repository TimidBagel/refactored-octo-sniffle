extends Node
class_name Civilization

signal population_changed
signal food_changed
signal water_changed
signal oxygen_changed
signal res_changed
signal fuel_changed

var civ_name
var population
var fuel_count
var oxygen_count
var food_count
var water_count
var resources
var building_list : Array[Building]
var parent_planet : Planet

# measured in people per day
var pop_growth_rate = 0.00000127

# measured in kilograms per day
@onready var oxygen_decrease_rate = 2.2
@onready var water_decrease_rate = 2.5
@onready var food_decrease_rate = 2.0

var tick = 0

# Called when the node enters the scene tree for the first time, init all starting values for a civilization
func _init(c_name, pop, fuel, oxygen, food, water, buildings : Array[Building], res, oxygen_decline = 2.2, water_decline = 2.5, food_decline = 2.0,):
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

func decrease_resource(amount):
	self.resources -= int(amount)

func passive_civilization_consumption():
	change_oxygen(population * -oxygen_decrease_rate)
	change_water(population * -water_decrease_rate)
	change_food(population * -food_decrease_rate)
	
func change_oxygen(amt):
	oxygen_count += amt
	oxygen_changed.emit()
	
func change_water(amt):
	water_count += amt
	water_changed.emit()
	
func change_food(amt):
	food_count += amt
	food_changed.emit()
	
func change_population(amt):
	population += amt
	population_changed.emit()

func change_fuel(amt):
	fuel_count += amt
	fuel_changed.emit()

func change_resource(amt):
	resources += amt
	res_changed.emit()

func population_growth():
	change_population(population * pop_growth_rate)

var time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if (time >= 1):
		passive_civilization_consumption()
		population_growth()
		#print_details()
		time = 0
		
func print_details():
	print("population - %d\nfood - %d\nwater - %d\noxygen - %d\nfuel - %d" % [population, food_count, water_count, oxygen_count, fuel_count])

func transfer_people(num, destination):
	population -= num
	destination.population += num

func transfer_food(num, destination):
	food_count -= num
	destination.food_count += num

func transfer_water(num, destination):
	water_count -= num
	destination.water_count += num

func transfer_oxygen(num, destination):
	oxygen_count -= num
	destination.oxygen_count += num

func transfer_fuel(num, destination):
	fuel_count -= num
	destination.fuel_count += num

func transfer_resource(num, destination):
	resources -= num
	destination.resources += num
