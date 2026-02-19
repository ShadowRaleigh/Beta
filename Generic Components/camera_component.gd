class_name CameraComponent extends Node

@export_range(0, 1) var lerp_weight:float = 0.75 
@export var camera: Camera3D
@export var camera_handler: Marker3D
@export var camera_holder: Node3D
@export var max_degree_rotation: float = 90

var time_since_last_frame: float

func _ready() -> void:
	if camera and find_child(camera.name):
		pass
	elif camera and not find_child(camera.name):
		push_error("A câmera designada não é filha do CameraComponent!")
		camera.call_deferred("reparent", self)
		
	else:
		camera = Camera3D.new()
		add_child(camera)

func smooth_camera_movement() -> void:
	if camera and camera_handler:
		camera.global_position.lerp(camera_handler.global_position, lerp_weight)

func rotate_camera_with_mouse(mouse_movent: Vector2, mouse_sensitivity: float): 
	var tweener = create_tween()
	
	tweener.tween_property(camera, "global_rotation:y", camera.global_rotation.y + deg_to_rad(-mouse_movent.x * mouse_sensitivity), time_since_last_frame)
	tweener.parallel().tween_property(camera, "rotation:x", clampf(camera.rotation.x + deg_to_rad(-mouse_movent.y * mouse_sensitivity), deg_to_rad(-max_degree_rotation), deg_to_rad(max_degree_rotation)), time_since_last_frame)
	tweener.parallel().tween_property(camera_holder, "global_rotation:y", camera.global_rotation.y, time_since_last_frame)

func _process(delta: float) -> void:
	time_since_last_frame = delta
	smooth_camera_movement()
