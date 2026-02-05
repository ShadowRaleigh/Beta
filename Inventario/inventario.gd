class_name Inventory
extends Node3D

@export var lista_de_itens: Array
@onready var item_holder = $Itemholder

var indice_atual: int = 0
var item_instanciado: Node = null

'''func _ready() -> void:
	exibir_item(indice_atual)

#Função para navegar no inventário
func _input(event: InputEvent) -> void:
	if InputEvent.is_action_just_pressed("ui_rigth"): mudar_indice(1)
	elif InputEvent.is_action_just_pressed(): mudar_indice(-1)

func mudar_indice(direcao:int) -> void:
	indice_atual += direcao
	# Sistema circular, se passar do fim volta para ao início
	if indice_atual >= lista_de_itens(): indice_atual = 0
	elif indice_atual < 0: indice_atual = lista_de_itens.size() - 1'''
