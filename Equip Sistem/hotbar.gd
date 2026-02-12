extends Control

@onready var slots_container = $CanvasLayer/HBoxContainer
@onready var slots = slots_container.get_children()

@export var empty_slot_texture: Texture2D 
@export var selection_border_texture: Texture2D # Textura para indicar seleção (borda)

func _ready():
	GameManager.inventory_updated.connect(update_ui)
	GameManager.slot_selected.connect(highlight_slot)
	
	# Inicialização
	update_ui()
	highlight_slot(GameManager.current_slot_index)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			GameManager.change_slot_selection(-1)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			GameManager.change_slot_selection(1)

func update_ui():
	for i in range(slots.size()):
		if i >= GameManager.hotbar_items.size(): break
		
		var item = GameManager.hotbar_items[i]
		var slot_ui = slots[i]
		
		if item:
			slot_ui.texture = item.icon 
		else:
			slot_ui.texture = empty_slot_texture

func highlight_slot(index):
	# Lógica para destacar o slot selecionado
	for i in range(slots.size()):
		if i == index:
			slots[i].modulate = Color(1, 1, 1, 1) # Cor normal
		else:
			slots[i].modulate = Color(0.5, 0.5, 0.5, 1) # Escurece os não selecionados
