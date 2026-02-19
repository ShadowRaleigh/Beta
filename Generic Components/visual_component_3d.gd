class_name VisualComponent3D extends Node3D

## Somente usar modelos 3D aqui
var model_scene:Resource :
	set(new_model_scene) :
		if new_model_scene:
			model_scene = new_model_scene
			instantiate_model()
var model:Node3D

func instantiate_model() -> void:
	if model_scene:
		if model:
			model.queue_free()
		model = model_scene.instantiate()
		add_child(model)
