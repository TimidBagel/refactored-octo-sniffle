extends Node
class_name building

var building_name
var modifier

var cost_to_buy
var pop_minimum
var pop_cap

func _init(b_name, modi, cost, pop, cap):
	self.building_name = b_name
	self.modifier = modi
	self.cost_to_buy = cost
	self.pop_minimum = pop
	self.pop_cap = cap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
