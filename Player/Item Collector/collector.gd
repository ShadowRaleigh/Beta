extends Node3D

@onready var detector: RayCast3D = $Detector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if detector.get_collider() and Input.is_action_just_pressed("collect"):
		var collected_object:Node3D = detector.get_collider()
		GameManager.inventory_list.append(collected_object.duplicate())
		collected_object.queue_free()

	print(GameManager.inventory_list)
