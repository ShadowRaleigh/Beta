class_name Inventory extends Node3D

var slot_scene:PackedScene = preload("uid://mk4k5vsav3hd")
@onready var camera_component: CameraComponent = $CameraComponent

var inventory_data:InventoryData = preload("uid://bwpotscgbhxbw")
var slot_array:Array[Slot]
var inventory_size: int = slot_array.size()
var current_slot_index := 0 :
	set(input):
		var next_slot_index:int = current_slot_index + input
		if next_slot_index >= inventory_size:
			next_slot_index = 0
		elif next_slot_index < 0:
			next_slot_index = inventory_size - 1
		
		update_slot_exhibition(next_slot_index)
		current_slot_index = next_slot_index

func _ready() -> void:
	populate_inventory()
	update_slot_exhibition()

func populate_inventory() -> void:
	for slot_data in inventory_data.slot_array:
		if slot_data.item_data:
			var slot: Slot = slot_scene.instantiate()
			slot.slot_data = slot_data
			add_child(slot)
			slot.hide()
			slot_array.append(slot)


func update_slot_exhibition(next_slot_index: int = 0) -> void:
	slot_array[current_slot_index].hide()
	slot_array[next_slot_index].show()
