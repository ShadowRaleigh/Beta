class_name MovementComponent extends Node3D

@export var body:CharacterBody3D
@export_range(0, 1) var lerp_weight: float = 0.5
@export var speed := 10.0
@export var jump_velocity := 10
@export var gravity_multiplier := 2

var raw_direction := Vector2.ZERO
var target_velocity := Vector3.ZERO
var jump_try := false

func move(delta: float) -> void:
	if not body:
		return
	var direction = global_basis * Vector3(raw_direction.x, 0, raw_direction.y).normalized()
	
	target_velocity = direction * speed
	body.velocity.x = lerp(body.velocity.x, target_velocity.x, lerp_weight)
	body.velocity.z = lerp(body.velocity.z, target_velocity.z, lerp_weight)
	
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * gravity_multiplier * delta
	
	if jump_try:
		jump()
	body.move_and_slide()
	
func jump() -> void:
	if body.is_on_floor():
		body.velocity.y = jump_velocity
