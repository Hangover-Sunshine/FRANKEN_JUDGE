extends Card

@onready var description_labels = [
	$Peasant_Card/Peasant_Card_Vbox/Peasant_Label1,
	$Peasant_Card/Peasant_Card_Vbox/Peasant_Label2,
	$Peasant_Card/Peasant_Card_Vbox/Peasant_Label3
]

var countdown_for_selection:float = 1.5

var _effects:Array[BaseEffectResource]

func show_labels(card_desc, effects:Array[BaseEffectResource]):
	for dl in description_labels:
		dl.visible = false
	##
	
	_effects = effects
	
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

func _on_mouse_entered():
	GlobalSignals.emit_signal("hovered_over_card", _effects)
##

func _on_mouse_exited():
	GlobalSignals.emit_signal("not_hovering")
##
