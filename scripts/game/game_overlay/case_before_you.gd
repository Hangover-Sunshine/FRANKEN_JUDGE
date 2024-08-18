extends Node2D

@onready var peasant_cards = [
	$Scale_Body/Scale_Left/Left_Peasant_Card,
	$Scale_Body/Scale_Right/Right_Peasant_Card
]
@onready var nobility_cards = [
	$Scale_Body/Scale_Left/Left_Nobility_Card,
	$Scale_Body/Scale_Right/Right_Nobility_Card
]
@onready var clergy_cards = [
	$Scale_Body/Scale_Left/Left_Clergy_Card,
	$Scale_Body/Scale_Right/Right_Clergy_Card
]

func setup_factions(factionA:GlobalData.Faction, factionB:GlobalData.Faction):
	# A, B - pick a numer 1 through 10 :)
	var aPicks = randi_range(1, 10)
	var bPicks = randi_range(1, 10)
	
	# If a > b, a is on the left
	# If a <= b, b is on the left
	if aPicks > bPicks:
		aPicks = 0
		bPicks = 1
	else:
		aPicks = 1
		bPicks = 0
	##
	
	var facACard
	var facBCard
	
	match factionA:
		GlobalData.Faction.CLERGY:
			facACard = clergy_cards[aPicks]
		##
		GlobalData.Faction.NOBILITY:
			facACard = nobility_cards[aPicks]
		##
		GlobalData.Faction.PEASANTS:
			facACard = peasant_cards[aPicks]
		##
	##
	
	match factionB:
		GlobalData.Faction.CLERGY:
			facBCard = clergy_cards[bPicks]
		##
		GlobalData.Faction.NOBILITY:
			facBCard = nobility_cards[bPicks]
		##
		GlobalData.Faction.PEASANTS:
			facBCard = peasant_cards[bPicks]
		##
	##
##
