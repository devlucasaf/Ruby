class Bingo
  TAM = 5

  def initialize
    @cartela = Array.new(TAM) { Array.new(TAM) }
    @marcacoes = Array.new(TAM) { Array.new(TAM, false) }
    @numeros_sorteados = []
    gerar_cartela
  end

  def jogar
    puts "BINGO"
    imprimir_cartela

    loop do
      numero = sortear_numero
      puts "\nNúmero sorteado: #{numero}"

      marcar_numero(numero)
      imprimir_cartela

      if verificar_vitoria
        puts "\nBINGO! VOCÊ VENCEU!"
        break
      end

      sleep 1
    end
  end

  private

  def gerar_cartela
    numeros_usados = []

    TAM.times do |i|
      TAM.times do |j|
        if i == 2 && j == 2
          @cartela[i][j] = 0
          @marcacoes[i][j] = true
          next
        end

        numero = nil
        loop do
          numero = rand(1..75)
          break unless numeros_usados.include?(numero)
        end

        numeros_usados << numero
        @cartela[i][j] = numero
      end
    end
  end

  def sortear_numero
    loop do
      numero = rand(1..75)
      unless @numeros_sorteados.include?(numero)
        @numeros_sorteados << numero
        return numero
      end
    end
  end

  def marcar_numero(numero)
    TAM.times do |i|
      TAM.times do |j|
        @marcacoes[i][j] = true if @cartela[i][j] == numero
      end
    end
  end

  def imprimir_cartela
    puts "-----------------------------"
    TAM.times do |i|
      TAM.times do |j|
        if i == 2 && j == 2
          print " FREE "
        elsif @marcacoes[i][j]
          print "[%2d] " % @cartela[i][j]
        else
          print " %2d  " % @cartela[i][j]
        end
      end
      puts
    end
    puts "-----------------------------"
  end

  def verificar_vitoria
    TAM.times do |i|
      linha_completa = true
      TAM.times do |j|
        unless @marcacoes[i][j]
          linha_completa = false
          break
        end
      end
      return true if linha_completa
    end

    TAM.times do |j|
      coluna_completa = true
      TAM.times do |i|
        unless @marcacoes[i][j]
          coluna_completa = false
          break
        end
      end
      return true if coluna_completa
    end

    diagonal1 = true
    TAM.times do |i|
      unless @marcacoes[i][i]
        diagonal1 = false
        break
      end
    end
    return true if diagonal1

    diagonal2 = true
    TAM.times do |i|
      unless @marcacoes[i][TAM - 1 - i]
        diagonal2 = false
        break
      end
    end
    diagonal2
  end
end

Bingo.new.jogar if __FILE__ == $0