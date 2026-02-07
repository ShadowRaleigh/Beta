class_name Inventory
extends Node3D

@export var lista_de_itens: Array[Item] = []
@onready var item_holder: Marker3D = $ItemHolder

var indice_atual: int = 0
var item_instanciado: Node = null
@export var velocidade_rotacao: float = 1.0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	if  GameManager.inventory_list:
		lista_de_itens = GameManager.inventory_list
	exibir_item(indice_atual)

"Nova função para rotação"
func _process(delta: float) -> void:
	if item_instanciado and item_instanciado is Node3D:
		item_instanciado.rotate_y(velocidade_rotacao * delta)
"--------------------------------------------------------------"

#Função para navegar no inventário
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_right"): mudar_indice(1)
	elif Input.is_action_just_pressed("ui_left"): mudar_indice(-1)

func mudar_indice(direcao:int) -> void:
	indice_atual += direcao
	# Sistema circular, se passar do fim volta para ao início
	if indice_atual >= len(lista_de_itens): indice_atual = 0
	elif indice_atual < 0: indice_atual = len(lista_de_itens) - 1
	
	exibir_item(indice_atual)

func exibir_item(index: int):
	# Remove o item anterior se ele existir
	if item_instanciado:
		item_instanciado.queue_free()
	
	# Instancia o novo item
	var novo_item_res: Item = lista_de_itens[index]
	if novo_item_res.item_component.idata.model:
		item_instanciado = novo_item_res.item_component.idata.model.instantiate()
		item_holder.add_child(item_instanciado)
		item_instanciado.position = Vector3.ZERO
