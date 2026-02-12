class_name Inventory
extends Node3D

@export var lista_de_itens: Array[Item] = []
@onready var item_holder: Marker3D = $ItemHolder
@onready var som_mudanca: AudioStreamPlayer = $som_mudanca

@onready var nome_label: Label = %Nome
@onready var descricao_label: RichTextLabel = %Descrição

@onready var next_button = $Control/next_button
@onready var last_button = $Control/last_button

var indice_atual: int = 0
var item_instanciado: Node = null
@export var velocidade_rotacao: float = 1.0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	if  GameManager.inventory_list:
		lista_de_itens = GameManager.inventory_list
	
	# Verifica se há itens antes de tentar exibir
	if lista_de_itens.size() > 0:
		exibir_item(indice_atual)
	else:
	# Lógica caso o inventário esteja vazio
		nome_label.text = "Vazio"
		descricao_label.text = ""

"Nova função para rotação"
func _process(delta: float) -> void:
	if item_instanciado and item_instanciado is Node3D:
		item_instanciado.rotate_y(velocidade_rotacao * delta)
"--------------------------------------------------------------"

#Função para navegar no inventário
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_right"): 
		mudar_indice(1)
		tocar_som()
	elif Input.is_action_just_pressed("ui_left"): 
		mudar_indice(-1)
		tocar_som()

func tocar_som() -> void:
	som_mudanca.pitch_scale = randf_range(0.9, 1.1) #Cara do video mostrou que isso muda o pitch não deixando repetitivo o som
	som_mudanca.play()

func mudar_indice(direcao:int) -> void:
	indice_atual += direcao
	# Sistema circular, se passar do fim volta para ao início
	if indice_atual >= len(lista_de_itens): indice_atual = 0
	elif indice_atual < 0: indice_atual = len(lista_de_itens) - 1
	
	exibir_item(indice_atual)

func exibir_item(index: int):
	# 1. Limpeza do item anterior
	if item_instanciado:
		item_instanciado.queue_free()
	
	# 2. Obter o recurso do item atual
	var novo_item_res: Item = lista_de_itens[index]
	 
	# 3. Instanciar o modelo 3D
	if novo_item_res.item_component.idata.model:
		item_instanciado = novo_item_res.item_component.idata.model.instantiate()
		item_holder.add_child(item_instanciado)
		item_instanciado.position = Vector3.ZERO
		
	# 4. ATUALIZAR A INTERFACE DE USUÁRIO (UI)
	# Acessa os dados do recurso e atualiza os Labels
	# Verifique os nomes exatos das variáveis no seu script 'Item' ou 'ItemData'
	if novo_item_res.item_component.idata:
		nome_label.text = novo_item_res.item_component.idata.name
		descricao_label.text = novo_item_res.item_component.idata.description


func _on_next_button_pressed() -> void:
	mudar_indice(1)
	tocar_som()

func _on_last_button_pressed() -> void:
	mudar_indice(-1)
	tocar_som()
