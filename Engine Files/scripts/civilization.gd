extends Node
class_name civilization

var civ_name
var population
var fuel_count
var oxygen_count
var food_count
var water_count
var resources
var building_list = []

# measured in people per day
var pop_growth_rate
var pop_decline_rate

# measured in kilograms per day
@onready var oxygen_decrease_rate = 2.2
@onready var water_decrease_rate = 2.5
@onready var food_decrease_rate = 2.0

var tick = 0

# Called when the node enters the scene tree for the first time, init all starting values for a civilization
func _init(c_name, pop, fuel, oxygen, food, water, buildings, res, oxygen_decline = 2.2, water_decline = 2.5, food_decline = 2.0,):
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
	self.oxygen_count -= float(self.population * self.oxygen_decrease_rate) 
	self.water_count -= float(self.population * self.water_decrease_rate)
	self.food_count -= float(self.population * self.food_decrease_rate)
	

func population_growth_decline():
	self.population -= int((self.population / (self.population / 10000) * self.pop_decline_multiplier))
	self.population += int((self.population / 1000) * self.pop_growth_multiplier)

var time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if (time >= 1):
		passive_civilization_consumption()
		#population_growth_decline()
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
