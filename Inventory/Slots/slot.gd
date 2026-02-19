class_name Slot extends Node3D

@export var slot_data: SlotData :
	set(new_data):
		slot_data = new_data
		if rotation_component and visual_component:
			_ready()

@onready var rotation_component: RotationComponent = $RotationComponent
@onready var visual_component: VisualComponent3D = $VisualComponent3D

var item_name:String
var description:String
var ammount:int

func _ready() -> void:
	if slot_data:
		var item_data := slot_data.item_data
		visual_component.model_scene = slot_data.item_data.model
		
		rotation_component.target = visual_component
		
		item_name = item_data.name
		description = item_data.description
		ammount = slot_data.ammount
