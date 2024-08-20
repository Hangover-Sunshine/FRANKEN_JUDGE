extends Control

@export var CaseCharactersPerLine:int = 70
@export var CaseCharactersIfLongWord:int = 10

@onready var casebrief_body = $Casebrief_Vbox/Casebrief_Body
@onready var case_name_header = $Casebrief_Vbox/Header_Hbox/CaseName_Header
@onready var case_number_letter = $Casebrief_Vbox/Header_Hbox/Case_Number_Letter

func show_brief(curr_day, case:BaseCaseResource, case_id:int):
	var display_text = (GlobalData.TWO_NUM_DISPLAY % curr_day) + ":" + str(case_id)
	case_number_letter.text = display_text
	case_name_header.text = case.CASE_NAME
	
	casebrief_body.visible = false
	
	casebrief_body.text = case.CASE_DESCRIPTION
	casebrief_body.visible = true
##
