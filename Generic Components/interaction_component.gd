class_name InteractionComponent extends Node

@export_range(0, 100) var interaction_range: float = 5
@export var holder:Marker3D
var interaction_collision_layer: int = 4
var ray: RayCast3D

func _ready() -> void:
	if holder:
		ray = RayCast3D.new()
		holder.add_child(ray)
		ray.target_position = Vector3(0, 0, -interaction_range)
		ray.collide_with_areas = true
		ray.collide_with_bodies = false
		ray.collision_mask = interaction_collision_layer

	else: push_error("InteractionComponent sem holder!!!")

func interact() -> void:
	ray.force_raycast_update()
	var event_loader:EventLoader = ray.get_collider()
	
	event_loader.execute_event()
