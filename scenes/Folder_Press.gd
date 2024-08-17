extends Button

@export var CaseID:int = 0

@onready var folder_labels_vbox = $Folder_Labels_Vbox
@onready var folder_label = $Folder_Labels_Vbox/Folder_Label

func _on_button_down():
	folder_labels_vbox.visible = false

func _on_button_up():
	folder_labels_vbox.visible = true

func set_case_title(case_name:String):
	folder_label.text = case_name
##

func _on_pressed():
	get_parent().emit_signal("case_picked", CaseID)
##
