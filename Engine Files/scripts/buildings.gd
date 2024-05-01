extends Node
class_name building

var owns : civilization

var building_name
var modifier

var cost_to_buy
var pop_minimum
var pop_cap

var cur_pop

func _init(b_name, modi, cost, pop, cap):
	self.building_name = b_name
	self.modifier = modi
	self.cost_to_buy = cost
	self.pop_minimum = pop
	self.pop_cap = cap


func assign_to_building(added):
	cur_pop += added
	
	if (cur_pop > pop_cap):
		var remainder = cur_pop - pop_cap
		cur_pop = pop_cap
		
		# return remainder just in case we may need the value
		return remainder
	
	return 0

# i dont know exactly where we would be calling this but we would ideally call this whenever a buildings pop changes
func calc_mod_bonus():
	if (cur_pop > pop_minimum):
		modifier = modifier + (cur_pop / pop_cap)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
