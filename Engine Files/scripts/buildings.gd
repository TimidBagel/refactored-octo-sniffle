extends Node
class_name Building

var owns: Civilization

var building_name: String
var modifier: float

var cost_to_buy: float
var pop_minimum: int
var pop_cap: int

var cur_pop: int


func _init(b_name: String, modi: float, cost: float, pop: int, cap: int) -> void:
	self.building_name = b_name
	self.modifier = modi
	self.cost_to_buy = cost
	self.pop_minimum = pop
	self.pop_cap = cap


func assign_to_building(added: int) -> int:
	cur_pop += added

	if cur_pop > pop_cap:
		var remainder := cur_pop - pop_cap
		cur_pop = pop_cap

		# return remainder just in case we may need the value
		return remainder

	return 0


# i dont know exactly where we would be calling this but we would ideally call this whenever a buildings pop changes
func calc_mod_bonus() -> void:
	if cur_pop > pop_minimum:
		modifier = modifier + (cur_pop / pop_cap)
