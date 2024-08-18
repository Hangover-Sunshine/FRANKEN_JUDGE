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
	
	var desc = ""
	
	# Go through and break up the string
	for i in range(case.CASE_DESCRIPTION.length()):
		if i > 0 and i % CaseCharactersPerLine == 0:
			desc += "\n"
		##
		
		desc += case.CASE_DESCRIPTION[i]
	##
	
	casebrief_body.text = desc
	casebrief_body.visible = true
##
