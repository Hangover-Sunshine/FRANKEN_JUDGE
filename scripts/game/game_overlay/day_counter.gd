extends Control

@onready var day_number_header = $Day_Number_Header

var day_total:int

## Only called once at the start of the game.
func set_day_total(total:int):
	day_total = total
##

## Called before "Part1" anim is played
func set_current_day(curr_day):
	day_number_header.text = (GlobalData.TWO_NUM_DISPLAY % curr_day) + " / " +\
								(GlobalData.TWO_NUM_DISPLAY % day_total)
##
