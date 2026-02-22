class_name SlotData extends Resource

@export var item_data:ItemData:
	set(new_data):
		if item_data != new_data:
			item_data = new_data
			item_data_changed.emit(self)

@export var ammount: int:
	set(new_ammount):
		if ammount != new_ammount:
			ammount = new_ammount
			ammount_changed.emit(self)

signal item_data_changed(slot)
signal ammount_changed(slot)
