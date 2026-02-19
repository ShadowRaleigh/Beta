class_name InputComponent extends Node

#region movement vars
var move_dir := Vector2.ZERO
var jump_pressed := false
#endregion

#region mouse vars
@export var mouse_sensitivity := 0.1
var mouse_movement: Vector2 = Vector2.ZERO
#endregion

#region inventory_input()
signal active_slot_changed(input)

func movement_input() -> void:
	move_dir = Input.get_vector("move_left", "move_right", "move_front", "move_back")
	jump_pressed = Input.is_action_just_pressed("jump")

func mouse_input(event: InputEvent) -> void: 
	if event is InputEventMouseMotion:
		mouse_movement = Vector2(event.screen_relative)

func inventory_change() -> void:
	Input.get_axis("previous_inv_item", "next_inv_item")
