class_name InventoryComponent extends Node

@export var inventory_data: InventoryData

func get_inventory_size() -> int:
	var size = inventory_data.slot_array.size()
	print("O tamanho do inventario é %s" % size)
	return size

func _ready() -> void:
	inventory_data.populate_null_slots()
