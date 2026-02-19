class_name Player extends CharacterBody3D

@onready var input_component: InputComponent = $InputComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var head: Marker3D = $Head

func _physics_process(delta: float) -> void:
	input_component.movement_input()
	movement_component.raw_direction = input_component.move_dir
	movement_component.jump_try = input_component.jump_pressed
	movement_component.move(delta)
