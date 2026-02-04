class_name Inventory
extends Node3D

@export var inventory_items: Array = []
@export var spawn_point: Marker3D #Vou usar isso para spawnar o modelo 3d do item a ser exibido
@export var name_label: Label
@export var description_label: RichTextEffect

var current_index: int = 0
var current_model: Node = null

func _ready() -> void:
	update_display()
	GameManager.inventory_camera = $SubViewportContainer/SubViewport/Camera3D
	GameManager.inventory_ui = $SubViewportContainer/SubViewport/CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"): #Tecla D
		change_item(1)
	elif event.is_action_pressed("ui_left"):
		change_item(-1)


func change_item(direction: int) -> void:
	if inventory_items.size() == 0: return
	
	#Lógica Cíclica
	current_index = (current_index + direction + inventory_items.size()) % inventory_items.size()
	update_display()
	
func update_display() -> void:
	if inventory_items.size() == 0: return
	var active_item = inventory_items[current_index]
	
	# Atualiza Textos
	name_label.text = active_item.name
	description_label.text = active_item.description
	
	# Limpa o modelo anterior
	if current_model:
		current_model.queue_free()
	
	# Instancia o novo modelo 3D
	if active_item.scene:
		current_model = active_item.scene.instantiate()
		spawn_point.add_child(current_model)
		# Adicionar animação dps aqui
