extends Button

@onready var folder_labels_vbox = $Folder_Labels_Vbox

func _on_button_down():
	folder_labels_vbox.visible = false

func _on_button_up():
	folder_labels_vbox.visible = true
