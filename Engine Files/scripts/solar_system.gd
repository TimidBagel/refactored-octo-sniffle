extends Node2D

class_name SolarSystem

@export var planets : Array[Planet]
@export var solar_system_name : String

func _ready():
	for child in get_children():
		if child is Planet:
			print('Body "' +  child.planet_name + '" recognized in the ' + solar_system_name + ' system!.')
