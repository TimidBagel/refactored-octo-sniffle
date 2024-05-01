extends Label
class_name ui_elements

var focused_civilization : civilization

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_civilization(civ):
	focused_civilization = civ

func change_text():
	set_text("Name: "+str(focused_civilization.civ_name)+"\n"+
			 "Population: "+str(focused_civilization.population)+"\n"+
			 "Food count: "+str(focused_civilization.food_count)+"\n"+
			 "Water count: "+str(focused_civilization.water_count)+"\n"+
			 "Oxygen count: "+str(focused_civilization.oxygen_count)+"\n"+
			 "Fuel count: "+str(focused_civilization.fuel_count)+"\n"+
			 "Resources: "+str(focused_civilization.fuel_count)+"\n")

