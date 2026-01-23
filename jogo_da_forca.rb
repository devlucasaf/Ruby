def palavraescondida
  # Retorna uma lista de palavras possíveis para o jogo da forca
  ["banana", "lorenx", "batata", "amostradinho", "receba", "ceub", "apendicite", "guilherme", "santiago", "aula", "samambaia"]
end

def linha
  # Imprime uma linha decorativa para separar seções do jogo
  puts "+=+=" * 56
end

def escolher_palavra(palavras)
  # Escolhe aleatoriamente uma palavra da lista e remove espaços extras
  palavras.sample.strip
end

def mostrar_palavra(palavra, letra_advinhada)
  # Mostra a palavra com as letras já adivinhadas e substitui as não adivinhadas por "_"
  palavra.chars.map { |letra| letra_advinhada.include?(letra) ? letra : "_" }.join(" ")
end

def jogo_forca
  # Função principal que executa o jogo da forca
  vida = 6                      # Número de tentativas (vidas) do jogador
  coracao = '❤️'                # Símbolo usado para representar vidas
  palavra_secreta = escolher_palavra(palavraescondida) # Seleciona a palavra secreta
  qntd_letra = palavra_secreta.length                  # Quantidade de letras da palavra
  letra_advinhada = []          # Lista de letras corretas já adivinhadas
  letra_errada = []             # Lista de letras incorretas já tentadas

  linha
  puts "Jogo da forca".center(224) # Exibe título centralizado
  linha
  puts "Essa sua palavra tem #{qntd_letra} letras"

  while vida > 0
    # Loop principal do jogo, continua enquanto o jogador tiver vidas
    puts mostrar_palavra(palavra_secreta, letra_advinhada) # Mostra progresso da palavra
    puts "Você tem #{coracao * vida}"                      # Mostra quantidade de vidas restantes

    print "Digite uma letra: "
    letra = gets.chomp.downcase # Lê a letra digitada pelo jogador e converte para minúscula

    if letra_advinhada.include?(letra) || letra_errada.include?(letra)
      # Verifica se a letra já foi digitada antes
      puts "Você já digitou essa letra! Tente novamente!"
      next
    end

    if palavra_secreta.include?(letra)
      # Caso a letra esteja na palavra secreta
      letra_advinhada << letra
      # Verifica se todas as letras foram adivinhadas
      if (palavra_secreta.chars.uniq - letra_advinhada).empty?
        puts "Você adivinhou a palavra secreta! A palavra secreta era: #{palavra_secreta}"
        break
      end
    else
      # Caso a letra não esteja na palavra secreta
      letra_errada << letra
      vida -= 1
      if vida == 0
        # Se o jogador perder todas as vidas
        puts "Você perdeu o jogo! A palavra era: #{palavra_secreta}"
      end
    end
  end
end

jogo_forca
# Inicia o jogo pela primeira vez

loop do
  # Loop para perguntar se o jogador deseja continuar jogando
  print "Digite [SIM] para continuar ou [NAO] para fechar o jogo: "
  digite = gets.chomp.upcase

  if digite == "SIM"
    # Reinicia o jogo
    jogo_forca
  elsif digite == "NAO"
    # Sai do loop e encerra o programa
    break
  else
    # Caso o usuário digite algo diferente de SIM ou NAO
    puts "A palavra digitada não é aceita! Tente novamente!"
  end
end
