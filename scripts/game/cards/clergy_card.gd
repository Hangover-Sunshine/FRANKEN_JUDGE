extends Card

@onready var description_labels = [
	$Clergy_card/Clergy_Card_Vbox/Clergy_Label1,
	$Clergy_card/Clergy_Card_Vbox/Clergy_Label2,
	$Clergy_card/Clergy_Card_Vbox/Clergy_Label3
]

@onready var effect_labels = [
	$Clergy_card/Clergy_Card_Vbox/Clergy_Rows/Row_Top/S1,
	$Clergy_card/Clergy_Card_Vbox/Clergy_Rows/Row_Top/S2,
	$Clergy_card/Clergy_Card_Vbox/Clergy_Rows/Row_Bot/S3,
	$Clergy_card/Clergy_Card_Vbox/Clergy_Rows/Row_Bot/S4
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
		
		if eff.Group == GlobalData.Faction.PEASANTS:
			effect_labels[elindex].set_symbol(1, eff.Affect)
		elif eff.Group == GlobalData.Faction.NOBILITY:
			effect_labels[elindex].set_symbol(2, eff.Affect)
		else:
			effect_labels[elindex].set_symbol(3, eff.Affect)
		##
		
		effect_labels[elindex].set_text(eff.ValueChange, eff.Affect == GlobalData.Effects.TAX)
		effect_labels[elindex].visible = true
		
		elindex += 1
	##
	
	description_labels[0].text = card_desc
	description_labels[0].visible = true
##

func _on_button_button_down():
	$Timer.start(countdown_for_selection)
	emit_signal("pressed_down")
##

func _on_button_button_up():
	$Timer.stop()
	emit_signal("released")
##

func _on_timer_timeout():
	emit_signal("selected", GlobalData.Faction.CLERGY, _effects)
##

func _on_mouse_entered():
	GlobalSignals.emit_signal("hovered_over_card", _effects)
##

func _on_mouse_exited():
	GlobalSignals.emit_signal("not_hovering")
##
