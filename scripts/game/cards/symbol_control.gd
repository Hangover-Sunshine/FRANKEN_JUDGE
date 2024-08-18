extends HBoxContainer

@onready var symbol = $Symbol
@onready var modifier = $Modifier

func set_symbol(row:int, effect:GlobalData.Effects):
	var base:int = row * 5
	
	match effect:
		GlobalData.Effects.TAX:
			symbol.frame = base
		GlobalData.Effects.LITERACY:
			symbol.frame = base + 2
		GlobalData.Effects.POLICING:
			symbol.frame = base + 3
		GlobalData.Effects.LABOR:
			symbol.frame = base + 1
		GlobalData.Effects.HEALTHCARE:
			symbol.frame = base + 4
		##
	##
##

func set_text(amnt:int):
	if symbol.frame % 5 == 0:
		if amnt < 0:
			modifier.text = "-" + (GlobalData.THREE_NUM_DISPLAY % -amnt)
		else:
			modifier.text = "+" + (GlobalData.THREE_NUM_DISPLAY % amnt)
		##
	else:
		if amnt < 0:
			modifier.text = "-" + (GlobalData.TWO_NUM_DISPLAY % -amnt)
		else:
			modifier.text = "+" + (GlobalData.TWO_NUM_DISPLAY % amnt)
		##
	##
##
