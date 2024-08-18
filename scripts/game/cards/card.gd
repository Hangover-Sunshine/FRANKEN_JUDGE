class_name Card
extends Panel

var regex = RegEx.new()

func _ready():
	regex.compile("[^A-Za-z]")
##

func parse_into_lines(card_desc:String) -> Array[String]:
	var lines = []
	
	var line = ""
	for i in range(card_desc.length()):
		line += card_desc[i]
		
		if (i + 1) % GlobalData.CHARACTERS_PER_CARD_LINE == 0:
			if card_desc[i] == " ":
				lines.append(line)
				line = ""
				continue
			##
			
			if card_desc[i + 1] == " ":
				lines.append(line)
				line = ""
				i += 1
				continue
			elif len(regex.search(card_desc[i + 1]).get_string(0)) > 0:
				line += "-"
				lines.append(line)
				line = ""
				continue
			##
		##
	##
	
	return lines
##
