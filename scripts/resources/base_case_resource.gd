class_name BaseCaseResource
extends Resource

@export var CASE_NAME:String
@export_multiline var CASE_DESCRIPTION:String

@export_group("Party A")
@export var PARTY_A:GlobalData.Faction
@export_multiline var PARTY_A_ARGUMENT:String
@export var EFFECTS_A:Array[BaseEffectResource]

@export_group("Party B")
@export var PARTY_B:GlobalData.Faction
@export_multiline var PARTY_B_ARGUMENT:String
@export var EFFECTS_B:Array[BaseEffectResource]
