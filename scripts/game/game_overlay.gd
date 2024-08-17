extends Node2D

signal cases_left(cases:Array[BaseCaseResource])

@onready var ap_states = $AP_States

var _cases:Array[BaseCaseResource]
var _case:BaseCaseResource
var _curr_day:int
var _case_ids:Array[int]

func initialize(max_num_days:int):
	$LilDays.set_day_total(max_num_days)
	$BigDays.set_day_total(max_num_days)
	$CasePick.connect("case_picked", _case_picked)
##

# ============== BOTTOM HALF CONTROL ============== #
func show_day(curr_day):
	# Set both
	$LilDays.set_current_day(curr_day)
	$BigDays.set_current_day(curr_day)
	_curr_day = curr_day
	
	# Play big day
	ap_states.play("Part1")
##

func show_cases(cases:Array[BaseCaseResource]):
	_cases = cases
	$CasePick/Button_Folder_Yellow.set_case_title(cases[0].CASE_NAME)
	$CasePick/Button_Folder_Blue.set_case_title(cases[1].CASE_NAME)
	$CasePick/Button_Folder_Red.set_case_title(cases[2].CASE_NAME)
##

func show_brief():
	var display_text = (GlobalData.TWO_NUM_DISPLAY % _curr_day) + ":" + str(_pick_rand_case_id)
	$CaseBrief/Casebrief_Vbox/Header_Hbox/Case_Number_Letter.text = display_text
	$CaseBrief/Casebrief_Vbox/Header_Hbox/CaseName_Header.text = _case.CASE_NAME
	
	$CaseBrief/Casebrief_Vbox/Casebrief_Body.visible = false
	
	var lines = _case.CASE_DESCRIPTION
	
##

func _case_picked(case_id:int):
	_case = _cases[case_id]
	_cases.remove_at(case_id)
	emit_signal("cases_left", _cases)
	show_brief()
##

func _pick_rand_case_id():
	var rand_id:int = randi_range(1000, 9999)
	
	while rand_id in _case_ids:
		rand_id = randi_range(1000, 9999)
	##
	
	_case_ids.append(rand_id)
	
	return rand_id
##
# ============== BOTTOM HALF CONTROL ============== #
