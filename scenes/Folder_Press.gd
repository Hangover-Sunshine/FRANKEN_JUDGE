extends Button

@export var CaseID:int = 0

@onready var peasantry_sticker = $Folder_Labels_Vbox/Folder_Stickers/Peasantry_Sticker
@onready var nobility_sticker = $Folder_Labels_Vbox/Folder_Stickers/Nobility_Sticker
@onready var clergy_sticker = $Folder_Labels_Vbox/Folder_Stickers/Clergy_Sticker
@onready var folder_labels_vbox = $Folder_Labels_Vbox
@onready var folder_label = $Folder_Labels_Vbox/Folder_Label

func show_groups(factionA:GlobalData.Faction, factionB:GlobalData.Faction):
	peasantry_sticker.visible = false
	nobility_sticker.visible = false
	clergy_sticker.visible = false
	
	if factionA == GlobalData.Faction.PEASANTS or factionB == GlobalData.Faction.PEASANTS:
		peasantry_sticker.visible = true
	##
	if factionA == GlobalData.Faction.CLERGY or factionB == GlobalData.Faction.CLERGY:
		clergy_sticker.visible = true
	##
	if factionA == GlobalData.Faction.NOBILITY or factionB == GlobalData.Faction.NOBILITY:
		nobility_sticker.visible = true
	##
##

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

func _on_mouse_entered():
	SoundManager.play_varied("folder", "hover", randf_range(0.9, 1.1))
##
