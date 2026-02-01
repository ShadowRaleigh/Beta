extends Node3D

const pan_speed:float = .05
@onready var component:InspectionComponent = $"Pistola/Inspection Component"
var component_ready:bool = false
var i_model:Resource
var i_name:String

var model_scene:Node3D

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

func _unhandled_input(event: InputEvent) -> void:
	pass
	
func move_item(delta):
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir:
		var tween:Tween = create_tween()
		tween.tween_property(model_scene, "position:x", model_scene.position.x - (input_dir.x * pan_speed), delta) 
		tween.tween_property(model_scene, "position:y", model_scene.position.y + (input_dir.y * pan_speed), delta)
