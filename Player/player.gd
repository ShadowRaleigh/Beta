class_name Player extends CharacterBody3D


@onready var movement_component: MovementComponent = $MovementComponent
@onready var head: Marker3D = $Head
@onready var camera_component: CameraComponent = $CameraComponent

func _ready() -> void:
	camera_component.setup_camera()

func _physics_process(delta: float) -> void:
	movement_component.raw_direction = InputManager.move_dir
	movement_component.jump_try = InputManager.jump_pressed
	movement_component.move(delta)
	camera_component.rotate_camera_with_mouse(InputManager.mouse_movement, InputManager.mouse_sensitivity)
	InputManager.mouse_movement = Vector2.ZERO
