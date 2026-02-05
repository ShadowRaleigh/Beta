extends Node

var inventory_ui: CanvasLayer
var inventory_list:Array[Node3D] = []
var is_inventory_open: bool = false #Começo com inventário fechado
@onready var inventory_scene: PackedScene = load("uid://831lsk4t3md6")


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
