class_name RotationComponent extends Node

## O corpo que será rodado pelo componente
@export var target: Node3D
## Velocidade que o alvo será rodado, em graus por segundo
@export var rotation_speed: int = 90

func _process(delta: float) -> void:
	target.rotation.y = clampf(target.rotation.y + deg_to_rad(rotation_speed * delta), 0, TAU) 
	if target.rotation.y >= TAU:
		target.rotation.y = 0
