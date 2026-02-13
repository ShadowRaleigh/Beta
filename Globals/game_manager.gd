extends Node

var inventory_ui: CanvasLayer
var inventory_list:Array[Item] = []
var is_inventory_open: bool = false #Começo com inventário fechado
@onready var inventory_scene: PackedScene = load("uid://831lsk4t3md6")
var inventory_instance: Node = null

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_inventory"): 
		if is_inventory_open: #Se is_inventory_open for verdadeiro ou seja 1
			close_inventory()
		else:                
			open_inventory()  
		get_viewport().set_input_as_handled()

func open_inventory() -> void:
	inventory_instance = inventory_scene.instantiate() #instantiate cria uma instancia da cena inventory
	inventory_instance.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_tree().root.add_child(inventory_instance) #Instance que é a cena do inv vira uma filha da arvore de cenas
	#o root faz com que a cena continua indenpendente da cena atual, assim o inv fica "independente"
	var inv_camera = inventory_instance.get_node_or_null("Camera3D")
	if inv_camera:
		inv_camera.make_current() #faz a camera do inventário ser a camera de uso atual
	
	is_inventory_open = true
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	#get_tree().paused = true

func close_inventory() -> void:
	if inventory_instance != null:
		inventory_instance.queue_free()
		inventory_instance = null
	
	# Busca a câmera do jogador pelo grupo e força ela a ser a ativa
	var main_camera = get_tree().get_first_node_in_group("MainCamera")
	if main_camera:
		main_camera.make_current() # Força a visão a voltar para o jogador
	
		is_inventory_open = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#get_tree().paused = false


"----------------------Seção do sistema de Equipar-----------------------"
signal hotbar_updated # Avisa a UI para atualizar o desenho
signal slot_selected(index) # Avisa o slot ativo

var hotbar_items: Array = [null, null, null] #Array com os 3 slots

var current_slot_index: int = 0 #inicio no indice 0 ou seja 1° posição

func equip_item_to_active_slot(item_data) -> void:
	#1. Proucura o item na hotbar
	var old_index = hotbar_items.find(item_data)
	
	#2. Vai ver se o item já existe:
	if old_index != null:
		# Se existir e for no mesmo slot
		if old_index == current_slot_index:
			return # Faz nada
		#Se ele estiver em outro slot, 1° limpa o slot antigo
		hotbar_items[old_index] = null
	
	#3. Coloca o item no novo slot (consequentemete subrescrevendo se tiver algo lá)
	hotbar_items[current_slot_index] = item_data
	
	#4. chama a UI de atualização:
	hotbar_updated.emit()

func change_slot_selection(direction: int):
	current_slot_index = (current_slot_index + direction) % hotbar_items.size()
	# Correção para módulo negativo (scroll para cima no índice 0)
	if current_slot_index < 0:
		current_slot_index = hotbar_items.size() - 1
	
	slot_selected.emit(current_slot_index)
