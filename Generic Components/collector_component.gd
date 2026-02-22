class_name CollectorComponent extends Node

@export var holder: Marker3D
@export var detection_range: float = 5

var ray:RayCast3D
var item_collision_layer: int = 2
var inventory: InventoryData

func _ready() -> void:
	ray = RayCast3D.new()
	ray.target_position = Vector3(0, 0 , -detection_range)
	holder.add_child(ray)
	
	ray.collision_mask = item_collision_layer

func collect_item() -> void:
	ray.force_raycast_update()
	var item:Item = ray.get_collider()
	if item:
		add_item_to_inventory(item)
		item.queue_free()

func add_item_to_inventory(item:Item) -> void:
	var slot_data = item.slot_data
	var item_data = slot_data.item_data
	
	var index = inventory.slot_array.find_custom(func(slot:SlotData): return slot.item_data == item_data)
	
	if index != -1:
		inventory.slot_array[index].ammount += slot_data.ammount
		
	else: 
		index = inventory.slot_array.find_custom(func(slot:SlotData): return slot.item_data == null)
		if index != -1:
			inventory.set_slot(index,  slot_data)
	
	inventory.save()
