class_name Inventory
extends Node3D

@export var lista_de_itens: Array[Node3D] = []
@onready var item_holder: Marker3D = $ItemHolder


var indice_atual: int = 0
var item_instanciado: Node = null

func _ready() -> void:
	var cena_chave: PackedScene = load("uid://daamjyh4461n7")
	var chave: Node3D = cena_chave.instantiate()
	item_holder.add_child(chave)
	lista_de_itens.append(chave)
	exibir_item(indice_atual)

#Função para navegar no inventário
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_rigth"): mudar_indice(1)
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
	var novo_item_res= lista_de_itens[index]
	if novo_item_res.ItemComponent.idata.model:
		item_instanciado = novo_item_res.scene.instantiate()
		item_holder.add_child(item_instanciado)
		# Opcional: Resetar a posição local para garantir que fique no centro
		item_instanciado.position = Vector3.ZERO
