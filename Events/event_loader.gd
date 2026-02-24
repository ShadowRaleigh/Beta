class_name EventLoader extends Area3D

@export var event_array: Array[Event]
@export var coll_mask: int = 0
var interaction_collision_layer: int = 4 ## Pelo sistema de operação, representa apenas a layer 3. Se 3 fosse usado, ele ficaria visível na layer 1 e 2

func _ready() -> void:
	self.collision_mask = coll_mask
	self.collision_layer = interaction_collision_layer

func execute_event() -> void:
	event_array.front().execute()

func execute_all_events() -> void:
	for event in event_array:
		event.execute()

func execute_especific_event(index: int) -> void:
	event_array[index].execute()
