extends Panel

@export var IsRight:bool = false

@onready var clergy_card = $Clergy_Card
@onready var nobility_card = $Nobility_Card
@onready var peasant_card = $Peasant_Card

func _ready():
	disable()
##

func enable():
	mouse_filter = Control.MOUSE_FILTER_PASS
	clergy_card.enable()
	nobility_card.enable()
	peasant_card.enable()
##

func disable():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	clergy_card.disable()
	nobility_card.disable()
	peasant_card.disable()
##

func set_countdown_time(dur:float):
	peasant_card.countdown_for_selection = dur
	nobility_card.countdown_for_selection = dur
	clergy_card.countdown_for_selection = dur
##

func hide_all():
	peasant_card.visible = false
	nobility_card.visible = false
	clergy_card.visible = false
##

func show_labels(group:GlobalData.Faction, card_desc, effects:Array[BaseEffectResource]):
	match group:
		GlobalData.Faction.PEASANTS:
			peasant_card.show_labels(card_desc, effects)
			peasant_card.visible = true
		GlobalData.Faction.NOBILITY:
			nobility_card.show_labels(card_desc, effects)
			nobility_card.visible = true
		GlobalData.Faction.CLERGY:
			clergy_card.show_labels(card_desc, effects)
			clergy_card.visible = true
		##
	##
##
