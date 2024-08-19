extends Control

# 0 = Yellow, 1 = Blue, 2 = Red
signal case_picked(case_id:int)

@onready var case_header = $Case_Header

const _DEFAULT_TEXT:String = "Pick a case..."

var _cases:Array[BaseCaseResource]

func _ready():
	$Button_Folder_Red.connect("mouse_entered", _red_entered)
	$Button_Folder_Blue.connect("mouse_entered", _blue_entered)
	$Button_Folder_Yellow.connect("mouse_entered", _yellow_entered)
	$Button_Folder_Red.connect("mouse_exited", _folder_exited)
	$Button_Folder_Blue.connect("mouse_exited", _folder_exited)
	$Button_Folder_Yellow.connect("mouse_exited", _folder_exited)
##

func enable():
	$Button_Folder_Blue.mouse_filter = MOUSE_FILTER_STOP
	$Button_Folder_Red.mouse_filter = MOUSE_FILTER_STOP
	$Button_Folder_Yellow.mouse_filter = MOUSE_FILTER_STOP
##

func disable():
	$Button_Folder_Blue.mouse_filter = MOUSE_FILTER_IGNORE
	$Button_Folder_Red.mouse_filter = MOUSE_FILTER_IGNORE
	$Button_Folder_Yellow.mouse_filter = MOUSE_FILTER_IGNORE
##

func here_the_cases(cases:Array[BaseCaseResource]):
	_cases = cases
##

func _red_entered():
	$Case_Header.text = _cases[2].CASE_NAME
##

func _blue_entered():
	$Case_Header.text = _cases[1].CASE_NAME
##

func _yellow_entered():
	$Case_Header.text = _cases[0].CASE_NAME
##

func _folder_exited():
	$Case_Header.text = _DEFAULT_TEXT
##
