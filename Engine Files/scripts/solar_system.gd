# Class which details the attributes and functionality of a Solar System
class_name SolarSystem extends Node2D

# solar system specific attributes and variables
@export var planets: Array[Planet]
@export var solar_system_name: String


# debug
func _ready() -> void:
	for child in get_children() as Array[Planet]:
		if child is Planet:
			print(
				(
					'Body "'
					+ child.planet_name
					+ '" recognized in the '
					+ solar_system_name
					+ " system!."
				)
			)
