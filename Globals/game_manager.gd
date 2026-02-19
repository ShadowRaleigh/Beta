extends Node

var main:Node

func _ready() -> void:
	main = get_tree().root.find_child("Main")
