# frozen_string_literal: true

class TermoGame
  def initialize

    @dicionario_palavras = %w[IDEIA CHAVE CENSO FURIA TEMPO FILHO FILHA
                              QUASE FATOR LAMBE BALDE VIRAR JOGOS LAÇOS
                              ILHAS PAPAI MAMAE MUNDO VULGO FORTE CULTO
                              JUSTO HONRA VIGOR VASCO SAGAZ NOBRE ANEXO
                              NEGRO MEXER PLENA FAZER MORAL DESDE JUSTO
                              ]
    @palavra_secreta = @dicionario_palavras.sample.upcase
    @tentativas = 6
  end

  def remover_acentos(texto)
    texto.tr(
      'ÁÉÍÓÚÂÊÎÔÛÃÕÇÀÈÌÒÙÄËÏÖÜÑ',
      'AEIOUAEIOUAOCAEIOUAEIOUN'
    )
  end

  def texto_animado(palavra_alvo)
    chars_possiveis = (' '..'z').to_a

    palavra_atual = Array.new(palavra_alvo.lenght, '*')

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
  def jogar
    puts ">>>>> JOGO DO TERMO <<<<<"

    @tentativas.times do |i|

    end
  end
end