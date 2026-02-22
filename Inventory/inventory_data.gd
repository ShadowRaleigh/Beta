class_name InventoryData extends Resource

@export var slot_array: Array[SlotData] = []:
	set(new_array):
		for slot in slot_array:
			if slot != null:
				if slot.ammount_changed.is_connected(emit_slot_changed):
					slot.ammount_changed.disconnect(emit_slot_changed)
				if slot.item_data_changed.is_connected(emit_slot_changed):
					slot.item_data_changed.disconnect(emit_slot_changed)
		
		slot_array = new_array
		
		for slot in slot_array:
			if slot != null:
				slot.ammount_changed.connect(emit_slot_changed)
				slot.item_data_changed.connect(emit_slot_changed)

signal slot_changed(slot)

func save() -> void:
	ResourceSaver.save(self)

func emit_slot_changed(slot) -> void:
	slot_changed.emit(slot)

func set_slot(index: int, new_slot: SlotData) -> void: ## Essa função deve ser usada toda vez que um SlotData for substiuído, no lugar de alterar diretamente pelo index. É importante pra garantir a conexão adequada dos sinais que monitoram as mudanças em cada slot
	var old_slot = slot_array[index]
	
	if old_slot != null:
		if old_slot.item_data_changed.is_connected(emit_slot_changed):
			old_slot.item_data_changed.disconnect(emit_slot_changed)
		if old_slot.ammount_changed.is_connected(emit_slot_changed):
			old_slot.ammount_changed.disconnect(emit_slot_changed)
	
	slot_array[index] = new_slot
	
	if new_slot != null:
		if not new_slot.item_data_changed.is_connected(emit_slot_changed):
			new_slot.item_data_changed.connect(emit_slot_changed)
		if not new_slot.ammount_changed.is_connected(emit_slot_changed):
			new_slot.ammount_changed.connect(emit_slot_changed)
	
	emit_slot_changed(new_slot)

func populate_null_slots() -> void: ## Troca todos os valores nulos no inventário por instâncias novas de SlotData, pra evitar crashes
	var needs_update = false
	
	for i in range(slot_array.size()):
		if slot_array[i] == null:
			slot_array[i] = SlotData.new()
			needs_update = true
			
	if needs_update:
		slot_array = slot_array
