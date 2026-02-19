extends Node3D

@onready var player: Player = $Player
@onready var camera_component: CameraComponent = $CameraComponent
@onready var input_component: InputComponent = $InputComponent

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera_component.camera_handler = player.head

func _unhandled_input(event: InputEvent) -> void:
	input_component.mouse_input(event)
	camera_component.rotate_camera_with_mouse(input_component.mouse_movement, input_component.mouse_sensitivity)
