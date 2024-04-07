extends Area2D

@export var dialogue_resource : DialogueResource
@export var dialogue_start : String = "start"
@export var icon : Sprite2D
@export var Inventory : Node2D
@export var InitialFlavourText : DialogueResource


func start() -> void:
	if dialogue_resource:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	elif Inventory:
		if GameState.has_interacted_with_chests == false:
			DialogueManager.show_example_dialogue_balloon(InitialFlavourText, "start")
			GameState.has_interacted_with_chests = true
		# Inventory.open()
		print("Inventory opened")
		
func _process(delta):
	if get_overlapping_areas():
		display_interact_icon()
	else:
		icon.hide()

func display_interact_icon():
	icon.show()
