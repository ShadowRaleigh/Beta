class_name CameraComponent extends Node

@export var camera: Camera3D
@export var camera_holder: Marker3D
@export var camera_owner: Node3D
@export var max_degree_rotation: float = 90 ##Relativo apenas à rotação horizontal

var rot_x: float = 0

func rotate_camera_with_mouse(mouse_movement: Vector2, mouse_sensitivity: float): 
	
	rot_x += deg_to_rad(-mouse_movement.y * mouse_sensitivity)
	rot_x = clampf(rot_x, deg_to_rad(-max_degree_rotation), deg_to_rad(max_degree_rotation))
	
	camera.rotation.x = rot_x
	camera_owner.rotate_y(deg_to_rad(-mouse_movement.x * mouse_sensitivity))
	
func spawn_camera():
	if camera and camera_holder and camera_holder.find_child(camera.name):
		pass
	elif camera and camera_holder and not camera_holder.find_child(camera.name):
		push_error("A câmera designada não é filha do %s!" % camera_holder.name)
		camera.call_deferred("reparent", camera_holder)
	elif camera_holder and not camera:
		camera = Camera3D.new()
		camera_holder.add_child(camera)
	elif not camera_holder and camera:
		push_warning("Holder não encontrado, setando a câmera como filha do componente")
		camera_holder.add_child(camera)
	else: 
		push_warning("Holder não encontrado, setando a câmera como filha do componente")
		camera = Camera3D.new()
		add_child(camera)
	
	camera.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_ON
	
	if camera_owner:
		pass
	elif camera_holder:
		camera_owner = camera_holder
		push_warning("Owner não encontrado, setando holder como owner")
	else:
		camera_owner = camera
		push_warning("Nem owner ou holder encontrado, setando câmera como owner")

func setup_camera():
	spawn_camera()
	rot_x = camera.rotation.x
