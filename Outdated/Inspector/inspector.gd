extends Node3D

const PAN_SPEED:float = .05 
const ROT_SPEED_DEGREES: float = 1
const MOUSE_DRAG_FACTOR:float = 15 #Precisa de modificadores pra quando o mouse é usado pra não ficar muito rápido
const MOUSE_ROT_FACTOR:float = 7
var frame_duration:float #Armazena o delta da _process() pra poder repassar pra outras funções



enum Mouse_Panning {
	NEUTRAL, #Nenhum botão do mouse pressionado
	DRAGGING, #Botão esquerdo pressioando
	ROTATING #Botão direito pressionado
}
var mouse_state:Mouse_Panning = Mouse_Panning.NEUTRAL


@onready var component:ItemComponent = $"Pistola/ItemComponent"
var component_ready:bool = false
var i_model:Resource
var i_name:String

var model_scene:Node3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED #faz o mouse aparecer, mas mantém ele preso na tela
	
func _process(delta: float) -> void:
	if not component:
		pass
	else: component_ready = true
	
	manage_component(delta)
	frame_duration = delta

func _unhandled_input(event: InputEvent) -> void: #
	match mouse_state: #checa o estado do mouse, e executa o comando baseado no evento
		Mouse_Panning.NEUTRAL:
			if event.is_action_pressed("insp_drag"):
				mouse_state = Mouse_Panning.DRAGGING
			elif event.is_action_pressed("insp_rotate"):
				mouse_state = Mouse_Panning.ROTATING
		
		Mouse_Panning.DRAGGING:
			if event is InputEventMouseMotion:
				var tween:Tween = create_tween()
				tween.tween_property(model_scene, "position",
				Vector3(
						model_scene.position.x + (event.screen_relative.x * PAN_SPEED / MOUSE_DRAG_FACTOR), #X
						model_scene.position.y - (event.screen_relative.y * PAN_SPEED / MOUSE_DRAG_FACTOR), #Y
						 0), #Z
						 frame_duration
						) 
			
			if event.is_action_released("insp_drag"):
				mouse_state = Mouse_Panning.NEUTRAL
				
		Mouse_Panning.ROTATING:
			if event is InputEventMouseMotion:
				var tween:Tween = create_tween()
				tween.tween_property(model_scene, "rotation_degrees", 
				Vector3(
						model_scene.rotation_degrees.x + (event.screen_relative.y * ROT_SPEED_DEGREES / MOUSE_ROT_FACTOR), #X
						model_scene.rotation_degrees.y - (event.screen_relative.x * ROT_SPEED_DEGREES / MOUSE_ROT_FACTOR), #Y
						0), #Z
						frame_duration
						)
			
			if event.is_action_released("insp_rotate"):
				mouse_state = Mouse_Panning.NEUTRAL
	
func move_item(delta) -> void: #função pra mover o item
	var input_dir:Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var rotation_dir:Vector2 = Input.get_vector("rotate_clock_X", "rotate_counterclock_X","rotate_clock_Y", "rotate_counterclock_Y")
	
	if input_dir:
		var tween:Tween = create_tween()
		tween.tween_property(model_scene, "position",
				Vector3(
						model_scene.position.x - (input_dir.x * PAN_SPEED), #X
						model_scene.position.y + (input_dir.y * PAN_SPEED), #Y
						 0), #Z
						 delta
						)  
		
	if rotation_dir: 
		var tween:Tween = create_tween()
		tween.tween_property(model_scene, "rotation_degrees",
				Vector3(
						model_scene.rotation_degrees.x + (rotation_dir.x * ROT_SPEED_DEGREES), #X
						model_scene.rotation_degrees.y + (rotation_dir.y * ROT_SPEED_DEGREES), #Y
						 0), #Z
						 delta
						) 

func manage_component(delta): #Instancia e gerencia o movimento e estado do modelo, ta meio bunda, mas depois eu refatoro
	if component_ready and not model_scene:
		i_model = component.idata.model
		i_name = component.idata.name
		model_scene = i_model.instantiate()
		add_child(model_scene)
	
	elif component_ready and model_scene:
		move_item(delta)
