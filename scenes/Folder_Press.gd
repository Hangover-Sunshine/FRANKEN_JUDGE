extends Button

@export var CaseID:int = 0

@onready var folder_labels_vbox = $Folder_Labels_Vbox
@onready var folder_label = $Folder_Labels_Vbox/Folder_Label

func _on_button_down():
	pass

func _on_button_up():
	pass

func set_case_title(case_name:String):
	folder_label.text = case_name
##

func _on_pressed():
	get_parent().emit_signal("case_picked", CaseID)
##
