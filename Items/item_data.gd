class_name ItemData extends Resource

@export var name: String
@export_multiline var description: String
@export_range(1, 99) var stack_size:int

@export var icon: Resource
@export var model: Resource

@export var can_rotate: bool
@export var mass:float = 1
@export var gravity_scale: float = 1
