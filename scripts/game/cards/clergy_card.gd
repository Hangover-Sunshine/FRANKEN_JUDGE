extends Card

@onready var description_labels = [
	$Clergy_Card_Vbox/Clergy_Label1,
	$Clergy_Card_Vbox/Clergy_Label2,
	$Clergy_Card_Vbox/Clergy_Label3
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
	emit_signal("selected_peasant")
##
