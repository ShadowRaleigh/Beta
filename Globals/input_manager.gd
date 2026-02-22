extends Node
#region movement
var move_dir := Vector2.ZERO
var jump_pressed := false
#endregion

#region mouse
var mouse_sensitivity := 0.1
var mouse_movement: Vector2 = Vector2.ZERO
#endregion

#region inventory
signal active_slot_changed(input:float)
signal inv_state_changed

#region collector
signal collecting

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func movement_input() -> void:
	move_dir = Input.get_vector("move_left", "move_right", "move_front", "move_back")
	jump_pressed = Input.is_action_pressed("jump")

func mouse_input(event: InputEvent) -> void: 
	if event is InputEventMouseMotion:
		mouse_movement += Vector2(event.screen_relative)

func inventory_change() -> void: ## Função que gerencia o input pros slots do inventário
	
	var input = Input.get_axis("previous_inv_item", "next_inv_item")
	if input: active_slot_changed.emit(input)

func inventory_toggle() -> void:
	var state_changed = Input.is_action_just_pressed("toggle_inventory")
	if state_changed:
		inv_state_changed.emit()

func collection_verification() -> void:
	if Input.is_action_just_pressed("collect"):
		collecting.emit()

func _unhandled_input(event: InputEvent) -> void:
	movement_input()
	mouse_input(event)
	
	inventory_change()
	inventory_toggle()
	
	collection_verification()
