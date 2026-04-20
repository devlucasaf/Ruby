class MegaSena
  def initialize
    # Inicializa a classe com um array vazio para armazenar os números do jogo
    @numeros_jogos_a_jogar = []
  end

  def gerar_jogo(quantidade_numeros)
    # Gera um jogo com a quantidade de números escolhida pelo usuário
    # Validação: só é permitido escolher entre 6 e 20 dezenas
    if quantidade_numeros < 6 || quantidade_numeros > 20
      raise ArgumentError, "Para jogar, escolha entre 6 e 20 dezenas."
    end

    # Sorteia números únicos entre 1 e 60 e ordena em ordem crescente
    @numeros_jogos_a_jogar = (1..60).to_a.sample(quantidade_numeros).sort
    @numeros_jogos_a_jogar
  end

  def custo_jogo_mega_sena(tamanho)
    # Tabela oficial de custos da Mega Sena conforme quantidade de dezenas escolhidas
    custos = {
      6 => 5.00,
      7 => 35.00,
      8 => 140.00,
      9 => 420.00,
      10 => 1050.00,
      11 => 2310.00,
      12 => 4620.00,
      13 => 8580.00,
      14 => 15015.00,
      15 => 25035.00,
      16 => 40040.00,
      17 => 61880.00,
      18 => 92820.00,
      19 => 135600.00,
      20 => 193800.00
    }
    # Retorna o custo correspondente ou 0.0 caso não exista na tabela
    custos.fetch(tamanho, 0.0)
  end

  def gravar_jogos
    # Grava os jogos gerados em um arquivo de texto
    begin
      File.open("mega-teste.txt", "a") do |f|
        f.puts "     Jogo para a Mega da Virada     "
        f.puts "                |                   "
        f.puts "------------------------------------"
        f.puts "    #{@numeros_jogos_a_jogar}"
        f.puts "------------------------------------"
        f.printf("- Valor total: R$%.2f ------\n", custo_jogo_mega_sena(@numeros_jogos_a_jogar.size))
        f.puts "\n\n"
      end
    rescue IOError => e
      # Caso ocorra erro ao salvar no arquivo
      puts "Erro ao salvar: #{e.message}"
    end
  end
end

# --- Programa Principal ---

ms = MegaSena.new
# Cria uma instância da classe MegaSena

print "Digite quantos jogos de Mega Sena quer fazer: "
num_jogos = gets.chomp.to_i
# Pergunta ao usuário quantos jogos deseja gerar

num_jogos.times do
  # Executa o loop para gerar a quantidade de jogos escolhida
  puts "\nNovo jogo!"
  print "Digite a quantidade de dezenas (6-20): "
  qtd = gets.chomp.to_i

  begin
    # Gera o jogo com a quantidade de dezenas escolhida
    jogo = ms.gerar_jogo(qtd)
    puts "Seu jogo está pronto! Números: #{jogo}"
    # Mostra os números sorteados

    printf("Custo da aposta: R$%.2f\n", ms.custo_jogo_mega_sena(qtd))
    # Mostra o custo da aposta conforme tabela

    ms.gravar_jogos
    # Grava o jogo em arquivo de texto
  rescue ArgumentError => e
    # Caso o usuário digite uma quantidade inválida de dezenas
    puts "Erro: #{e.message}"
  end
end
