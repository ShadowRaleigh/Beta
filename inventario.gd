extends Node3D

@onready var anchor = $SubViewportContainer/SubViewport/ItemAnchor
var itens = [] #Lista de caminhos para os modelos 3D
var indice_atual = 0

func _ready(): 
	#Carregar itens
	itens = ["res://Pistola/Pistol.blend"]
