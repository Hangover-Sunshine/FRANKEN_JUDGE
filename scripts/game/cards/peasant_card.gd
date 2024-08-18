extends Card

@onready var description_labels = [
	$Peasant_Card_Vbox/Peasant_Label1,
	$Peasant_Card_Vbox/Peasant_Label2,
	$Peasant_Card_Vbox/Peasant_Label3
]

func _ready():
	super()
##

func show_labels(card_desc):
	var lines = parse_into_lines(card_desc)
	
	for i in range(lines.size()):
		description_labels[i] = lines[i]
		description_labels[i].visible = true
	##
##
