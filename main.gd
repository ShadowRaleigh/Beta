class_name Main extends Node

@export var current_level: Level
@export var inventory: Inventory
@export var next_level_scene: PackedScene

func _ready() -> void:	
	inventory.hide()
	current_level.show()
	
	GameManager.main = self
	GameManager.current_level = current_level
	GameManager.next_level_scene = next_level_scene
	GameManager.inventory = inventory

	inventory.inventory_data = current_level.player.inventory_component.inventory_data
