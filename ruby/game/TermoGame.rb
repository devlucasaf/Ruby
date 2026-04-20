# frozen_string_literal: true
# Congela literais de String para evitar alocação desnecessária (micro-otimização em Ruby).

class TermoGame
  def initialize
    # Dicionário de palavras possíveis (todas com 5 letras, e algumas com acentos).
    @dicionario_palavras = %w[
      IDEIA CHAVE CENSO FURIA TEMPO FILHO FILHA
      QUASE FATOR LAMBE BALDE VIRAR JOGOS LAÇOS
      ILHAS PAPAI MAMAE MUNDO VULGO FORTE CULTO
      JUSTO HONRA VIGOR VASCO SAGAZ NOBRE ANEXO
      NEGRO MEXER PLENA FAZER MORAL DESDE ETICA
      SENSO AFETO ALGOZ SANAR CARNE CERNE SOBRE
      FOSSE POREM AUDAZ AUDAX RAZAO ICONE ETNIA
      FUNIL FUTIL DENGO TARDE NOITE MANHA SABER
      SEARA CASAL XIBIU DEVER CAUSA TENAZ SENDO
      AINDA TEMOR DIZER MESMO COZER VICIO TODOS
      CRIAR JEITO FRACO DENSO DOGMA ORDEM REGRA
      LOUCO PEDIR PEIDO AJUDA HOMEM CLAVA USURA
      IMPOR BANAL COISA JUIZO FALSO LEGAL FORMA
      CERTO FALAR PROSA PROVA SERVO TENRO POSSO
      PODER VENDO HEROI PRESA PIFIO LINDA VISAR
      MANSO SERIO MAGOA GUISA MEIGA ACASO PUDER
      FLUIR IMPIO LUGAR REAÇA TEMER PLATO ABRIR
      PEIXE SANTO BURRO MATIZ OBVIO CISMA UNIAO
      EXODO CRISE PLENO ALIBI TEDIO RITMO FLUXO
      MORTE SENIL LEVAR HAVIA OLHAR CASTA TOMAR
      ENFIM VISAO GENIO OUVIR PARVO PARDO PRETO
      BREGA CABAL PORCO TOURO RELES REDES FALTA
      VITAL CALMA OUTRO BRAVO TECER FAVOR TERRA
      UNICO LAICO PASSO VALIA PAPEL GLOBO REVER
      NOSSA CARMA POBRE ROGAR EPICO COESO ATIVO
      ANELO CLARO LEIGO SELAR LIDER OBITO SESTA
      CIUME SINTO VAZIO CESTA SONSO DETER ATUAR
      FICAR VELHO GENTE HASTE TENDE ADIAR HUMOR
      REVEL FONTE IDEAL PONTO SULCO ARDUO SABOR
      SENAO REMIR MARCO SARUE FEIXE HIATO AMPLO
      VEMOS CAPAZ TANTO LARVA LAVRA DEBIL CAUDA
      RELVA CICLO TENRA INATA VARAO VIRAO JOVEM
      OTICA CHUVA GESTO AMBOS RAICA POUCO TOADA
      SONSA APOIO VELAR VACUO XEQUE ALGUM FARAO
      VIMOS VAMOS HORDA FEITO FUSAO CARRO ADVEM
      AVIAO NAVIO LEITO ENTRE SORTE PROBO MINHA
      TRAMA CRUEL SENTE ANUAL LAZER FRASE BRISA
      IMPAR VERSO CHATA CHATO MAIOR MENOR RIGOR
    ]

    # Escolhe uma palavra aleatória do dicionário
    @palavra_secreta = @dicionario_palavras.sample.upcase

    @secreta_logica = remover_acentos(@palavra_secreta)

    # Número máximo de tentativas no jogo (estilo Termo/Wordle)
    @tentativas_maximas = 6
  end

  # Remove acentos de uma String substituindo caracteres acentuados pelas versões ASCII.
  def remover_acentos(texto)
    texto.tr(
      'ÁÉÍÓÚÂÊÎÔÛÃÕÇÀÈÌÒÙÄËÏÖÜÑ',
      'AEIOUAEIOUAOCAEIOUAEIOUN'
    )
  end

  # Exibe uma animação "digitando" revelando cada letra gradualmente (efeito fun).
  # Não interfere na lógica do jogo, é puramente visual.
  def texto_animado(palavra_alvo)
    chars_possiveis = (' '..'z').to_a

    palavra_atual = Array.new(palavra_alvo.length, '*')

    palavra_alvo.chars.each_with_index do |letra_correta, index|
      chars_possiveis.each do |char_teste|
        sleep(0.02)                       # Pequena pausa para a animação
        palavra_atual[index] = char_teste # Mostra o caractere testado
        print "\r#{palavra_atual.join}"   # Sobrescreve a linha atual no terminal
        break if char_teste == letra_correta
      end
    end
    puts
  end

  # Calcula as cores de feedback do chute:
  # :verde   -> letra correta na posição correta
  # :amarelo -> letra existe na palavra, mas em outra posição (respeitando multiplicidade)
  # :cinza   -> letra não existe (ou já “consumida” pelas contagens)
  def calcular_cores(chute)
    # Trabalhamos com a versão sem acento para justiça na comparação
    secreta_chars = @secreta_logica.chars
    chute_chars   = chute.chars

    # Inicialmente tudo cinza
    resultado_cores = Array.new(5, :cinza)

    # Contagem de ocorrências por letra da palavra secreta (para tratar duplicatas corretamente)
    contagem_letras = Hash.new(0)
    secreta_chars.each { |l| contagem_letras[l] += 1 }

    # Primeiro passe: marca VERDES e desconta a contagem
    chute_chars.each_with_index do |letra, i|
      if letra == secreta_chars[i]
        resultado_cores[i] = :verde
        contagem_letras[letra] -= 1
      end
    end

    # Segundo passe: marca AMARELOS onde houver sobras de ocorrências
    chute_chars.each_with_index do |letra, i|
      next if resultado_cores[i] == :verde

      if contagem_letras[letra] > 0
        resultado_cores[i] = :amarelo
        contagem_letras[letra] -= 1
      end
    end

    resultado_cores
  end

  # Mostra no terminal o chute com as cores (ANSI):
  # verde (fundo 42), amarelo (fundo 43), cinza/preto (fundo 40)
  def animacao_terminal(palavra, cores_array)
    # Limpa a linha anterior de forma simples
    print "\r" + (" " * 30) + "\r"

    palavra.chars.each_with_index do |letra, index|
      cor = case cores_array[index]
            when :verde   then "\e[42m\e[30m" # fundo verde, letra preta
            when :amarelo then "\e[43m\e[30m" # fundo amarelo, letra preta
            else               "\e[40m\e[37m" # fundo preto, letra branca (cinza)
            end

      print "#{cor} #{letra} \e[0m "
      STDOUT.flush
      sleep(0.5) # Pequena pausa para efeito de revelação em sequência
    end
    puts ""
  end

  # Animação final estilo "Matrix" para mensagens de vitória/derrota
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

  # Loop principal do jogo
  def jogar
    limpar_tela
    puts ">>>>>> JOGO DO TERMO <<<<<<"
    puts "-------------------------"

    @tentativas_maximas.times do |i|
      @tentativas_atual = i + 1
      print "\nTentativa #{@tentativas_atual}/#{@tentativas_maximas}: "

      # Lê o chute do usuário (do terminal), normaliza para maiúsculas
      chute = gets.chomp.upcase

      # Validação: o jogo exige palavras de 5 letras
      if chute.length != 5
        puts "⚠️  A palavra precisa ter 5 letras!"
        redo # volta para a mesma tentativa (não consome tentativa)
      end

      # Remove acentos para comparar com a versão lógica da palavra secreta
      chute_logico = remover_acentos(chute)

      # Calcula as cores com base no chute lógico
      cores = calcular_cores(chute_logico)

      # Exibe a animação colorida com o chute original (mantém acentos na visualização)
      animacao_terminal(chute, cores)

      # Condição de vitória
      if chute_logico == @secreta_logica
        puts "\n"
        animar_texto_matrix("PARABENS! VOCE VENCEU!")
        puts "A palavra era: #{@palavra_secreta}"
        return # Sai do método e encerra o jogo
      end
    end

    # Se esgotou as tentativas e não acertou
    puts "\n💀 Fim de jogo!"
    puts "A palavra era: #{@palavra_secreta}"
  end

  # Limpa a tela de maneira compatível com Unix (clear) e Windows (cls)
  def limpar_tela
    system("clear") || system("cls")
  end
end

# Inicia o jogo instanciando a classe e chamando o método principal
TermoGame.new.jogar
