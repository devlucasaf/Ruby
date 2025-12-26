def palavraescondida
  ["banana", "lorenx", "batata", "amostradinho", "receba", "ceub", "apendicite", "guilherme", "santiago", "aula", "samambaia"]
end

def linha
  puts "+=+=" * 56
end

def escolher_palavra(palavras)
  palavras.sample.strip
end

def mostrar_palavra(palavra, letra_advinhada)
  palavra.chars.map { |letra| letra_advinhada.include?(letra) ? letra : "_" }.join(" ")
end

def jogo_forca
  vida = 6
  coracao = '❤️'
  palavra_secreta = escolher_palavra(palavraescondida)
  qntd_letra = palavra_secreta.length
  letra_advinhada = []
  letra_errada = []

  linha
  puts "Jogo da forca".center(224)
  linha
  puts "Essa sua palavra tem #{qntd_letra} letras"

  while vida > 0
    puts mostrar_palavra(palavra_secreta, letra_advinhada)
    puts "Você tem #{coracao * vida}"

    print "Digite uma letra: "
    letra = gets.chomp.downcase

    if letra_advinhada.include?(letra) || letra_errada.include?(letra)
      puts "Você já digitou essa letra! Tente novamente!"
      next
    end

    if palavra_secreta.include?(letra)
      letra_advinhada << letra
      if (palavra_secreta.chars.uniq - letra_advinhada).empty?
        puts "Você adivinhou a palavra secreta! A palavra secreta era: #{palavra_secreta}"
        break
      end
    else
      letra_errada << letra
      vida -= 1
      if vida == 0
        puts "Você perdeu o jogo! A palavra era: #{palavra_secreta}"
      end
    end
  end
end

jogo_forca

loop do
  print "Digite [SIM] para continuar ou [NAO] para fechar o jogo: "
  digite = gets.chomp.upcase

  if digite == "SIM"
    jogo_forca
  elsif digite == "NAO"
    break
  else
    puts "A palavra digitada não é aceita! Tente novamente!"
  end
end
