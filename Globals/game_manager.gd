extends Node

var main:Main
var current_level: Level
var inventory: Inventory
var next_level_scene: PackedScene
var next_level_instance: Level

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	InputManager.inv_state_changed.connect(toggle_inventory)

func toggle_inventory():
	
	current_level.player.camera_component.current = !current_level.player.camera_component.current
	inventory.camera_component.current = !inventory.camera_component.current
	inventory.ui_layer.visible = !inventory.ui_layer.visible
	
	current_level.visible = !current_level.visible
	inventory.visible = !inventory.visible
	get_tree().paused = !get_tree().paused
	
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	else: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func move_to_next_level() -> void:
	next_level_instance = next_level_scene.instantiate()
	current_level.queue_free()
	current_level = next_level_instance
	main.add_child(current_level)
	main.current_level = current_level
	main.next_level_scene = null
	
	inventory.inventory_data = current_level.player.inventory_component.inventory_data
