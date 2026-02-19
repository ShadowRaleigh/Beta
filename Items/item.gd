class_name Item extends RigidBody3D

#region components
@onready var visual_component: VisualComponent3D = $Visual3DComponent
#endregion

@export var slot_data:SlotData
@onready var item_data = slot_data.item_data

func _ready() -> void:
	visual_component.model_scene = item_data.model
