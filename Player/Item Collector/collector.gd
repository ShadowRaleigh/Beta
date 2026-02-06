extends Node3D

@onready var detector: RayCast3D = $Detector


func _physics_process(_delta: float) -> void:
	if detector.get_collider() and Input.is_action_just_pressed("collect"):
		var collected_object:Node3D = detector.get_collider()
		GameManager.inventory_list.append(collected_object.duplicate())
		collected_object.queue_free()
