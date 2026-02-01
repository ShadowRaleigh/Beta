extends Node3D

const PAN_SPEED:float = .05
const ROT_SPEED_DEGREES: float = 1

enum mouse_panning {
	NEUTRAL,
	STARTED_DRAGGING,
	DRAGGING,
	RELEASED,
}

@onready var component:InspectionComponent = $"Pistola/Inspection Component"
var component_ready:bool = false
var i_model:Resource
var i_name:String

var model_scene:Node3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
func _process(delta: float) -> void:
	if not component:
		pass
	else: component_ready = true
	
	if component_ready and not model_scene:
		i_model = component.idata.model
		i_name = component.idata.name
		model_scene = i_model.instantiate()
		add_child(model_scene)
	
	elif component_ready and model_scene:
		move_item(delta)

func _unhandled_input(_event: InputEvent) -> void:
	pass
	
func move_item(delta) -> void:
	var input_dir:Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	@warning_ignore("narrowing_conversion")
	var rotation_dir:Vector2 = Input.get_vector("rotate_clock_X", "rotate_counterclock_X","rotate_clock_Y", "rotate_counterclock_Y")
	
	if input_dir:
		var tween:Tween = create_tween()
		tween.tween_property(model_scene, "position:x", model_scene.position.x - (input_dir.x * PAN_SPEED), delta) 
		tween.tween_property(model_scene, "position:y", model_scene.position.y + (input_dir.y * PAN_SPEED), delta)
		
	if rotation_dir: 
		var tween:Tween = create_tween()
		tween.tween_property(model_scene, "rotation_degrees:x", model_scene.rotation_degrees.x + (rotation_dir.x * ROT_SPEED_DEGREES), delta)
		tween.tween_property(model_scene, "rotation_degrees:y", model_scene.rotation_degrees.y + (rotation_dir.y * ROT_SPEED_DEGREES), delta)
