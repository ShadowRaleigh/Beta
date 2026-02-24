class_name Inventory extends Node3D

var slot_scene:PackedScene = preload("uid://mk4k5vsav3hd")

@onready var camera_component: CameraComponent = $CameraComponent
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var ui_layer: CanvasLayer = $UILayer

@onready var name_label: Label = $UILayer/HBoxContainer/VBoxContainer/NameLabel
@onready var description_label: Label = $UILayer/HBoxContainer/VBoxContainer/DescriptionLabel
@onready var ammount_label: Label = $UILayer/HBoxContainer/VBoxContainer/AmmountLabel


@export var inventory_data:InventoryData: #= preload("uid://bwpotscgbhxbw"):
	set(new_data):
		inventory_data = new_data
		inventory_data.slot_changed.connect(update_inventory_slots)
		update_inventory_slots()

var slot_array:Array[Slot] = []
var slot_data_array:Array[SlotData] = []
var inventory_size: int
var current_slot_index := 0 :
	set(next_result):
		if can_process():
			var next_slot_index:int = next_result
			
			if next_result >= inventory_size:
				next_slot_index = 0
			
			elif next_result < 0:
				next_slot_index = inventory_size - 1
			
			update_slot_exhibition(next_slot_index)
			current_slot_index = next_slot_index

func _ready() -> void:
	populate_inventory()
	update_slot_exhibition()
	InputManager.active_slot_changed.connect(update_selected_slot)

func populate_inventory() -> void:
	if inventory_data:
		for slot_data in inventory_data.slot_array:
			if slot_data.item_data and not slot_data_array.has(slot_data):
				var slot: Slot = slot_scene.instantiate()
				slot.slot_data = slot_data
				add_child(slot)
				slot.hide()
				slot_array.append(slot)
				slot_data_array.append(slot_data)
		inventory_size = slot_array.size()

func clear_inventory() -> void:
	for slot in slot_array:
		if not inventory_data.slot_array.has(slot.slot_data):
			slot_data_array.erase(slot.slot_data)
			slot_array.erase(slot)
			slot.queue_free()

func update_selected_slot(input) -> void:
	current_slot_index += input

func update_slot_exhibition(next_slot_index: int = 0) -> void:
	if slot_array:
		slot_array[current_slot_index].hide()
		slot_array[next_slot_index].show()
		audio_stream_player.play()
		
		if name_label:
			name_label.text = "Nome: %s" % slot_array[next_slot_index].item_name
			description_label.text = "Descrição: %s" % slot_array[next_slot_index].description
			ammount_label.text = "Quantidade: %s" % slot_array[next_slot_index].ammount

func update_inventory_slots(_slot = 0) -> void:
	clear_inventory()
	populate_inventory()
	update_slot_exhibition()
