extends Card

@onready var description_labels = [
	$Nobility_Card/Nobility_Card_Vbox/Nobility_Label1,
	$Nobility_Card/Nobility_Card_Vbox/Nobility_Label2,
	$Nobility_Card/Nobility_Card_Vbox/Nobility_Label3
]

@onready var effect_labels = [
	$Nobility_Card/Nobility_Card_Vbox/Noble_Rows/Row_Top/S1,
	$Nobility_Card/Nobility_Card_Vbox/Noble_Rows/Row_Top/S2,
	$Nobility_Card/Nobility_Card_Vbox/Noble_Rows/Row_Bot/S3,
	$Nobility_Card/Nobility_Card_Vbox/Noble_Rows/Row_Bot/S4
]

var countdown_for_selection:float = 1.5
var _effects:Array[BaseEffectResource]

func show_labels(card_desc, effects:Array[BaseEffectResource]):
	for dl in description_labels:
		dl.visible = false
	##
	
	for el in effect_labels:
		el.visible = false
	##
	
	_effects = effects
	
	var elindex = 0
	for eff in effects:
		# skip reputation ones, not necessary
		if eff.Affect == GlobalData.Effects.REPUTATION:
			continue
		##
		
		effect_labels[elindex].set_symbol(2, eff.Affect)
		effect_labels[elindex].set_text(eff.ValueChange)
		effect_labels[elindex].visible = true
		
		elindex += 1
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

func _on_mouse_entered():
	GlobalSignals.emit_signal("hovered_over_card", _effects)
##

func _on_mouse_exited():
	GlobalSignals.emit_signal("not_hovering")
##
