extends Label
class_name ui_elements

var to_display

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_text(txt):
	to_display = txt
	set_text(to_display)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_text()
	pass
