@tool
class_name ItemComponent
extends Node

@export var idata:ItemData
@export_tool_button("Load Model","Camera3DDarkBackground") var model_visualizer = visualizer

func visualizer():
	var instance = idata.model.instantiate()
	add_child(instance)
