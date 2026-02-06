extends Node

var inventory_ui: CanvasLayer
var inventory_list:Array[Item] = []
var is_inventory_open: bool = false #Começo com inventário fechado
@onready var inventory_scene: PackedScene = load("uid://831lsk4t3md6")
var inventory_instance: Node = null

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	elif Input.is_action_just_pressed("toggle_inventory"): 
		if is_inventory_open: #Se is_inventory_open for verdadeiro ou seja 1
			close_inventory() #chama func de fechar o inventário
		else:                 #se não
			open_inventory()  #chama func de abrir o inventário

func open_inventory() -> void:
	inventory_instance = inventory_scene.instantiate() #instantiate cria uma instancia da cena inventory
	inventory_instance.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_tree().root.add_child(inventory_instance) #Instance que é a cena do inv vira uma filha da arvore de cenas
	#o root faz com que a cena continua indenpendente da cena atual, assim o inv fica "independente"
	var inv_camera = inventory_instance.get_node_or_null("Camera3D")
	if inv_camera:
		inv_camera.make_current() #faz a camera do inventário ser a camera de uso atual
	
	is_inventory_open = true #atualiza do estado do inventário
	get_tree().paused = true #pausa a cena, pausando o jogo

func close_inventory() -> void:
	if inventory_instance != null:
		inventory_instance.queue_free() # Remove o nó da cena e libera a memória
		inventory_instance = null       # Limpa a referência para evitar erros futuros
		is_inventory_open = false
		get_tree().paused = false
