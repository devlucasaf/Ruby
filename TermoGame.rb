# frozen_string_literal: true

class TermoGame
  def initialize
    @dicionario_palavras = %w[
      IDEIA CHAVE CENSO FURIA TEMPO FILHO FILHA
      QUASE FATOR LAMBE BALDE VIRAR JOGOS LAÇOS
      ILHAS PAPAI MAMAE MUNDO VULGO FORTE CULTO
      JUSTO HONRA VIGOR VASCO SAGAZ NOBRE ANEXO
      NEGRO MEXER PLENA FAZER MORAL DESDE JUSTO
    ]

    # Escolhe uma palavra aleatória
    @palavra_secreta = @dicionario_palavras.sample.upcase

    # CORREÇÃO 1: Criamos a variável lógica (sem acentos) para usar nas comparações
    @secreta_logica = remover_acentos(@palavra_secreta)

    @tentativas_maximas = 6
  end

  def remover_acentos(texto)
    texto.tr(
      'ÁÉÍÓÚÂÊÎÔÛÃÕÇÀÈÌÒÙÄËÏÖÜÑ',
      'AEIOUAEIOUAOCAEIOUAEIOUN'
    )
  end

  def texto_animado(palavra_alvo)
    chars_possiveis = (' '..'z').to_a

    # CORREÇÃO 2: Corrigido de 'lenght' para 'length'
    palavra_atual = Array.new(palavra_alvo.length, '*')

    palavra_alvo.chars.each_with_index do |letra_correta, index|
      chars_possiveis.each do |char_teste|
        sleep(0.02)
        palavra_atual[index] = char_teste
        print "\r#{palavra_atual.join}"
        break if char_teste == letra_correta
      end
    end
    puts
  end

  def calcular_cores(chute)
    # Aqui usamos a @secreta_logica que criamos no initialize
    secreta_chars = @secreta_logica.chars
    chute_chars = chute.chars
    resultado_cores = Array.new(5, :cinza)
    contagem_letras = Hash.new(0)

    secreta_chars.each { |l| contagem_letras[l] += 1 }

    # Passo 1: Verdes
    chute_chars.each_with_index do |letra, i|
      if letra == secreta_chars[i]
        resultado_cores[i] = :verde
        contagem_letras[letra] -= 1
      end
    end

    # Passo 2: Amarelos
    chute_chars.each_with_index do |letra, i|
      next if resultado_cores[i] == :verde

      if contagem_letras[letra] > 0
        resultado_cores[i] = :amarelo
        contagem_letras[letra] -= 1
      end
    end

    resultado_cores
  end

  def animacao_terminal(palavra, cores_array)
    print "\r" + (" " * 30) + "\r"

    palavra.chars.each_with_index do |letra, index|
      cor = case cores_array[index]
            when :verde   then "\e[42m\e[30m"
            when :amarelo then "\e[43m\e[30m"
            else               "\e[40m\e[37m"
            end

      print "#{cor} #{letra} \e[0m "
      STDOUT.flush
      sleep(0.5)
    end
    puts ""
  end

  def animar_texto_matrix(frase_final)
    chars_possiveis = ('A'..'Z').to_a + ['!', '@', '#', '$', '%']
    palavra_atual = Array.new(frase_final.length, ' ')

    frase_final.chars.each_with_index do |letra_alvo, i|
      10.times do
        palavra_atual[i] = chars_possiveis.sample
        print "\r✨ #{palavra_atual.join} ✨"
        sleep(0.01)
      end
      palavra_atual[i] = letra_alvo
      print "\r✨ #{palavra_atual.join} ✨"
    end
    puts "\n"
  end

  def jogar
    limpar_tela
    puts ">>>>> JOGO DO TERMO <<<<<"
    puts "-------------------------"

    @tentativas_maximas.times do |i|
      @tentativas_atual = i + 1
      print "\nTentativa #{@tentativas_atual}/#{@tentativas_maximas}: "

      chute = gets.chomp.upcase

      if chute.length != 5
        puts "⚠️  A palavra precisa ter 5 letras!"
        redo
      end

      chute_logico = remover_acentos(chute)

      # CORREÇÃO 3: Nome do método corrigido (calcular_cores)
      # CORREÇÃO 4: Passamos o 'chute_logico' para calcular a cor corretamente
      cores = calcular_cores(chute_logico)

      # Na animação usamos o 'chute' original (para mostrar o acento na tela)
      animacao_terminal(chute, cores)

      # CORREÇÃO 5: Lógica de vitória completada e 'end' adicionados
      if chute_logico == @secreta_logica
        puts "\n"
        animar_texto_matrix("PARABENS! VOCE VENCEU!")
        puts "A palavra era: #{@palavra_secreta}"
        return # Sai do jogo
      end
    end

    puts "\n💀 Fim de jogo!"
    puts "A palavra era: #{@palavra_secreta}"
  end

  def limpar_tela
    system("clear") || system("cls")
  end
end

# Inicia o jogo
TermoGame.new.jogar