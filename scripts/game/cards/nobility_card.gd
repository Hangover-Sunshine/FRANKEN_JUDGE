extends Card

@onready var description_labels = [
	$Nobility_Card_Vbox/Nobility_Label1,
	$Nobility_Card_Vbox/Nobility_Label2,
	$Nobility_Card_Vbox/Nobility_Label3
]

var countdown_for_selection:int = 1.5

func show_labels(card_desc):
	for dl in description_labels:
		dl.visible = false
	##
	
	description_labels[0].text = card_desc
	description_labels[0].visible = true
##

func _on_button_button_down():
	$Timer.start(countdown_for_selection)
##

func _on_button_button_up():
	$Timer.stop()
##

func _on_timer_timeout():
	emit_signal("selected")
##
