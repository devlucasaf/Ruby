$voto_totais = []

puts """Escolha entre as seguintes opções de candidatos
22 - Leanderson
13 - Mario Bitcoin
14 - Ribamar
0 - Nulo
9 - Encerrar"""

def eleicao
  loop do
    print "Digite o seu voto: "
    voto = gets.chomp.to_i

    if [22, 13, 14, 0].include?(voto)
      $voto_totais << voto
      puts "Voto Confirmado!"

    elsif voto == 9
      puts "Votação Encerrada!"
      break

    else
      puts "Número digitado não identificado a nenhum candidato! Tente outro número!"
      next
    end
  end

  votos_leanderson = $voto_totais.count(22)
  votos_mario = $voto_totais.count(13)
  votos_ribamar = $voto_totais.count(14)
  votos_nulo = $voto_totais.count(0)

  if $voto_totais.size > 0
    resultados = {"Leanderson" => votos_leanderson, "Mario Bitcoin" => votos_mario, "Ribamar" => votos_ribamar}
    eleito, votos_eleito = resultados.max_by { |_, valor| valor }

    total_votos = $voto_totais.size.to_f
    if votos_nulo > votos_eleito
      puts "Votação anulada! Os votos nulos venceram com #{votos_nulo}"
      puts "\nVotação recomeçada!\n"

      # Exibe o menu de candidatos
      puts """Escolha entre as seguintes opções de candidatos:
              22 - Leanderson
              13 - Mario Bitcoin
              14 - Lucao
              0 - Nulo
              9 - Encerrar
              """

      # Reinicia a lista de votos
      $voto_totais.clear
      eleicao
    end

    porcentagem_leanderson = (votos_leanderson / total_votos) * 100
    porcentagem_mario = (votos_mario / total_votos) * 100
    porcentagem_ribamar = (votos_ribamar / total_votos) * 100
    porcentagem_nulo = (votos_nulo / total_votos) * 100

    puts "\nRESULTADOS:"
    puts "Leanderson: #{votos_leanderson} votos (#{porcentagem_leanderson.round(2)}%)"
    puts "Mario Bitcoin: #{votos_mario} votos (#{porcentagem_mario.round(2)}%)"
    puts "Ribamar: #{votos_ribamar} votos (#{porcentagem_ribamar.round(2)}%)"
    puts "Nulos: #{votos_nulo} votos (#{porcentagem_nulo.round(2)}%)"
    puts "\nCandidato eleito: #{eleito} com #{votos_eleito} votos!"
  else
    puts "Nenhum voto foi registrado."
  end
end

eleicao
