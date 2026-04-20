# Loop infinito que só termina quando o usuário escolher parar
loop do
  # Solicita ao usuário um número inteiro
  print "Digite um número: "
  o = gets.chomp.to_i

  # Loop que itera pelos números de 1 a 10 (inclusive)
  (1..10).each do |num|
    soma = o + num
    multiplicacao = o * num
    divisao = o.to_f / num
    subtracao = o - num

    # Imprime os resultados formatados em uma linha
    puts format(
      "%d + %2d = %2d  |  %d x %2d = %3d  |  %3d / %2d = %2d  |  %3d - %2d = %2d",
      o, num, soma, o, num, multiplicacao, multiplicacao, o, num, soma, o, num
    )
  end

  # Pergunta se o usuário deseja continuar
  print "Deseja continuar? SIM/NAO: "
  mat = gets.chomp.upcase

  # Se a resposta for "NAO", encerra o loop
  break if mat == "NAO"
end
