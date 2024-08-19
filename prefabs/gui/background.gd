extends Node2D

@onready var ap = $AP_Hate

## Current faction who hates you most ##
# 0 = noone really | 1 = peasantry | 2 = nobility | 3 = clergy #
var next_faction = 0
var curr_faction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	ap.play("RESET")

func change_hater():
	if next_faction == 1:
		if curr_faction == 0:
			ap.play("Neutral_To_Peasantry")
			curr_faction = 1
		if curr_faction == 2:
			ap.play("Nobility_To_Peasantry")
			curr_faction = 1
		if curr_faction == 3:
			ap.play("Clergy_To_Peasantry")
			curr_faction = 1
	elif next_faction == 2:
		if curr_faction == 0:
			ap.play("Neutral_To_Nobility")
			curr_faction = 2
		if curr_faction == 1:
			ap.play("Peasantry_To_Nobility")
			curr_faction = 2
		if curr_faction == 3:
			ap.play("Clergy_To_Nobility")
			curr_faction = 2
	elif next_faction == 3:
		if curr_faction == 0:
			ap.play("Neutral_To_Clergy")
			curr_faction = 3
		if curr_faction == 1:
			ap.play("Peasantry_To_Clergy")
			curr_faction = 3
		if curr_faction == 2:
			ap.play("Nobility_To_Clergy")
			curr_faction = 3
	elif next_faction == 0:
		if curr_faction == 1:
			ap.play("Peasantry_To_Neutral")
			curr_faction = 0
		if curr_faction == 2:
			ap.play("Nobility_To_Neutral")
			curr_faction = 0
		if curr_faction == 3:
			ap.play("Clergy_Neutral")
			curr_faction = 0
