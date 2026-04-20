notas = [200, 100, 50, 20, 10, 5, 2]
# Lista com os valores das notas disponíveis no caixa eletrônico

qntd_nota_estoque = [50, 50, 50, 50, 50, 50, 50]
# Quantidade de cada nota disponível (estoque inicial: 50 de cada)

valor_total = 0
# Variável que armazenará o valor total disponível no caixa

notas.each_with_index do |nota, i|
  # Percorre cada nota junto com seu índice
  valor_total += nota * qntd_nota_estoque[i]
  # Multiplica o valor da nota pela quantidade disponível e soma ao total
end

puts "Nesse caixa, tem disponível: R$ #{'%.2f' % valor_total}"
# Exibe o valor total disponível no caixa formatado com duas casas decimais

loop do
  # Loop principal para permitir múltiplos saques
  print "Digite quanto você quer sacar: "
  saque = gets.chomp.to_f
  # Lê o valor do saque solicitado pelo usuário

  if saque > valor_total
    # Verifica se o saque solicitado é maior que o valor disponível
    puts "Saque indisponível! Valor maior do que disponível!"
    puts "O valor máximo para saque permitido neste terminal é de: R$ #{'%.2f' % valor_total}"
    next
    # Volta para o início do loop sem processar o saque
  end

  resto = saque
  # Variável que representa o valor restante a ser distribuído em notas

  notas.each do |nota|
    # Percorre cada tipo de nota disponível
    if resto / nota >= 1
      # Verifica se ainda é possível usar essa nota no saque
      qntd = (resto / nota).to_i
      # Calcula quantas notas desse valor serão usadas
      resto -= (qntd * nota)
      # Subtrai do valor restante
      puts "A quantidade de notas de R$ #{nota} é de: #{qntd} notas"
      # Exibe quantas notas desse valor foram entregues
    end
  end

  valor_total -= saque
  # Atualiza o valor total disponível no caixa após o saque

  puts "Neste caixa tem R$ #{'%.2f' % valor_total} em notas de #{notas}"
  # Exibe o valor restante no caixa e quais notas estão disponíveis

  if valor_total <= 0
    # Caso o caixa fique sem dinheiro
    puts "Você conseguiu estourar o caixa"
    break
    # Encerra o programa
  end

  print "Deseja realizar um novo saque? Sim/Não: "
  new_saque = gets.chomp.strip.upcase
  # Pergunta ao usuário se deseja continuar jogando

  break if new_saque == "NAO"
  # Se o usuário digitar "NAO", encerra o loop e o programa
end
