extends Node

var player_camera: Camera3D
var inventory_camera: Camera3D
var inventory_ui: CanvasLayer
var is_inventory_open: bool = false #Começo com inventário fechado
@onready var inventory_scene: PackedScene = load("uid://831lsk4t3md6")


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("ui_focus_next"): # Tecla TAB
		toggle_inventory()

func toggle_inventory() -> void:
	is_inventory_open = !is_inventory_open
	if is_inventory_open:
		inventory_camera.make_current()
		inventory_ui.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		player_camera.make_current()
		inventory_ui.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
