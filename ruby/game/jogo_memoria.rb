class JogoMemoria
  OPCOES = ['A', 'B', 'C', 'D']
  TEMPO_PAUSA_MS = 800

  def initialize
    @sequencia = []
    @random = Random.new
  end

  def jogar
    puts "      JOGO DA MEMÓRIA - GENIUS     "
    puts "Memorize a sequência de letras!"
    puts "Opções: A, B, C, D"
    puts "Pressione ENTER para começar..."
    $stdin.gets

    rodada = 1
    jogando = true

    while jogando
      puts "\n--- RODADA #{rodada} ---"

      adicionar_elemento
      mostrar_sequencia
      limpar_tela

      resposta = ler_resposta

      if verificar_resposta(resposta)
        puts "Correto! Próxima rodada..."
        rodada += 1
        esperar(1200)
      else
        puts "Errado!"
        puts "Fim de jogo!"
        puts "Pontuação final: #{rodada - 1}"
        jogando = false
      end
    end
  end

  private

  def adicionar_elemento
    @sequencia << gerar_elemento
  end

  def gerar_elemento
    OPCOES[@random.rand(OPCOES.length)]
  end

  def mostrar_sequencia
    puts "Memorize a sequência:"
    @sequencia.each do |c|
      puts "  #{c}"
      esperar(TEMPO_PAUSA_MS)
    end
  end

  def ler_resposta
    resposta = []
    puts "Digite a sequência (uma letra por vez):"

    @sequencia.size.times do |i|
      print "Elemento #{i + 1}: "
      entrada = $stdin.gets.chomp.strip.upcase
      resposta << (entrada.length == 1 ? entrada[0] : ' ')
    end

    resposta
  end

  def verificar_resposta(resposta)
    @sequencia.each_with_index do |val, i|
      return false unless val == resposta[i]
    end
    true
  end

  def limpar_tela
    40.times { puts }
  end

  def esperar(tempo_ms)
    sleep(tempo_ms / 1000.0)
  rescue Interrupt
    Thread.current.raise Interrupt
  end
end

JogoMemoria.new.jogar if __FILE__ == $0