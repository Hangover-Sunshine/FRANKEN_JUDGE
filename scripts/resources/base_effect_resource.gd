class_name BaseEffectResource
extends Resource

@export var Group:GlobalData.Faction

## What is being modified.
@export var Affect:GlobalData.Effects

## Make it a random amount changed.
@export var RandomAmount:bool = false

## The amount of the affected being changed. Ignored if random amount is set.
@export var ValueChange:int = 1

## The range to generate between for changing a value. Ignored if RandomAmount is false. 
@export var ValueRange:Vector2i = Vector2i(1, 5)
