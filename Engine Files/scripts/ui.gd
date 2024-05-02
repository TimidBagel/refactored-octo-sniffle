extends CanvasLayer

class_name UI

@onready var planet_name = $Control/ColorRect/Name
@onready var population_count = $Control/ColorRect/PopulationCount
@onready var water_source = $"Control/ColorRect/WaterSource?"
@onready var breatheable = $"Control/ColorRect/Breathable?"
@onready var planet_image = $Control/ColorRect/ImageContainer/PlanetImage

var current_planet : planet

func set_planet(planet_ : planet):
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


func _on_button_pressed():
	self.visible = false
