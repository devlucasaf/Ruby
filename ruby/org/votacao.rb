$voto_totais = []
# Variável global que armazena todos os votos registrados

puts """Escolha entre as seguintes opções de candidatos
22 - Leanderson
13 - Mario Bitcoin
14 - Ribamar
0 - Nulo
9 - Encerrar"""
# Exibe o menu inicial de candidatos e opções

def eleicao
  # Função principal que executa o processo de votação
  loop do
    # Loop para registrar votos até que seja encerrado
    print "Digite o seu voto: "
    voto = gets.chomp.to_i
    # Lê o voto digitado pelo usuário e converte para inteiro

    if [22, 13, 14, 0].include?(voto)
      # Se o voto for válido (pertencer à lista de candidatos ou nulo)
      $voto_totais << voto
      puts "Voto Confirmado!"

    elsif voto == 9
      # Caso o usuário digite 9, encerra a votação
      puts "Votação Encerrada!"
      break

    else
      # Caso o número não corresponda a nenhum candidato
      puts "Número digitado não identificado a nenhum candidato! Tente outro número!"
      next
    end
  end

  # Contagem dos votos por candidato
  votos_leanderson = $voto_totais.count(22)
  votos_mario = $voto_totais.count(13)
  votos_ribamar = $voto_totais.count(14)
  votos_nulo = $voto_totais.count(0)

  if $voto_totais.size > 0
    # Se houver votos registrados
    resultados = {"Leanderson" => votos_leanderson, "Mario Bitcoin" => votos_mario, "Ribamar" => votos_ribamar}
    # Cria um hash com os resultados dos candidatos

    eleito, votos_eleito = resultados.max_by { |_, valor| valor }
    # Determina o candidato com maior número de votos

    total_votos = $voto_totais.size.to_f
    # Calcula o total de votos como número decimal

    if votos_nulo > votos_eleito
      # Caso os votos nulos sejam maiores que os votos do candidato mais votado
      puts "Votação anulada! Os votos nulos venceram com #{votos_nulo}"
      puts "\nVotação recomeçada!\n"

      # Exibe novamente o menu de candidatos
      puts """Escolha entre as seguintes opções de candidatos:
              22 - Leanderson
              13 - Mario Bitcoin
              14 - Lucao
              0 - Nulo
              9 - Encerrar
              """

      # Reinicia a lista de votos
      $voto_totais.clear
      # Chama novamente a função para reiniciar a votação
      eleicao
    end

    # Calcula porcentagens de votos para cada candidato
    porcentagem_leanderson = (votos_leanderson / total_votos) * 100
    porcentagem_mario = (votos_mario / total_votos) * 100
    porcentagem_ribamar = (votos_ribamar / total_votos) * 100
    porcentagem_nulo = (votos_nulo / total_votos) * 100

    # Exibe os resultados finais
    puts "\nRESULTADOS:"
    puts "Leanderson: #{votos_leanderson} votos (#{porcentagem_leanderson.round(2)}%)"
    puts "Mario Bitcoin: #{votos_mario} votos (#{porcentagem_mario.round(2)}%)"
    puts "Ribamar: #{votos_ribamar} votos (#{porcentagem_ribamar.round(2)}%)"
    puts "Nulos: #{votos_nulo} votos (#{porcentagem_nulo.round(2)}%)"
    puts "\nCandidato eleito: #{eleito} com #{votos_eleito} votos!"
  else
    # Caso nenhum voto tenha sido registrado
    puts "Nenhum voto foi registrado."
  end
end

eleicao
# Inicia o processo de votação
