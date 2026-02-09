@tool
extends EditorScript

func _run():
	# 1. Carregar o recurso da receita
	var receita = load("res://Craft/craft_lata_aberta.tres") as Craft
	
	# Verificação básica se o recurso foi carregado
	if not receita:
		printerr("Erro: Não foi possível carregar a receita.")
		return

	print("Iniciando Teste da Receita")
	
	# 2. Testar propriedades básicas (Dados)
	print("Resource Name (Nativo): ", receita.resource_name)
	print("Recipe Name (Customizado): ", receita.recipe_name)
	assert(receita.name != "", "Erro: O nome da receita está vazio!")
	
	# Verifica se existem ingredientes e resultados
	print("Qtd. Ingredientes: ", receita.ingredients.size())
	assert(receita.ingredients.size() > 0, "Erro: A receita não tem ingredientes!")
	
	print("Qtd. Resultados: ", receita.result.size())
	assert(receita.result.size() > 0, "Erro: A receita não gera nenhum resultado!")

	# 3. Simular a Lógica de Craft (Teste Funcional)
	var inventario_mock = ["lata_fechada", "abridor"] 
	
	var pode_craftar = verificar_ingredientes(receita, inventario_mock)
	
	if pode_craftar:
		print("SUCESSO: O jogador possui os itens necessários.")
	else:
		printerr("FALHA: Ingredientes insuficientes no teste.")
		
	print("--- Fim do Teste ---")

# Função auxiliar para simular a verificação do inventário
func verificar_ingredientes(receita: Craft, inventario: Array) -> bool:
	for item_necessario in receita.ingredients:
		var item_encontrado = false
		
		# Lógica simples de busca
		if item_necessario in inventario:
			item_encontrado = true
			
		if item_necessario == null:
			printerr("Erro: Um dos ingredientes na receita é nulo!")
			return false
			
	return true
