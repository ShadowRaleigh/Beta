class_name event_loader extends Node

@export var event_array: Array[Event]

func execute_event() -> void:
	event_array.front().execute()

func execute_all_events() -> void:
	for event in event_array:
		event.execute()

func execute_especific_event() -> void:
	pass
