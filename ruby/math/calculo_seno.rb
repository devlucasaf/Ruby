def calcular_seno(angulo) 
  # Define um método chamado 'calcular_seno' que recebe um ângulo em graus

  rad = angulo * 3.14 / 180
  # Converte o ângulo de graus para radianos (aproximação de π = 3.14)

  puts rad
  # Exibe o valor em radianos (apenas para conferência)

  seno = 0.0
  # Inicializa a variável que acumulará o valor do seno

  n = 0
  # Contador para controlar os termos da série de Taylor

  loop do
    # Inicia um loop infinito, que será interrompido manualmente

    exponencial = (2 * n + 1)
    # Calcula o expoente da potência (fórmula da série de Taylor do seno)

    numerador = ((-1) ** n) * (rad ** exponencial)
    # Calcula o numerador do termo da série: (-1)^n * rad^(2n+1)

    denominador = (1..(2 * n + 1)).inject(:*) 
    # Calcula o fatorial de (2n+1) usando Range e inject

    termo = numerador.to_f / denominador
    # Calcula o termo da série de Taylor

    break if termo.abs < 0.0001
    # Interrompe o loop se o termo for muito pequeno (precisão desejada)

    seno += termo
    # Soma o termo ao valor acumulado do seno

    n += 1
    # Incrementa o contador para calcular o próximo termo
  end

  return seno
  # Retorna o valor aproximado do seno
end

def main
  # Define o método principal do programa

  print "Ângulo em graus: "
  # Solicita ao usuário que digite um ângulo em graus

  angulo = gets.to_f
  # Lê o valor digitado e converte para número de ponto flutuante

  seno = calcular_seno(angulo)
  # Chama a função 'calcular_seno' para obter o valor do seno

  puts "O seno de #{angulo} graus = #{seno}"
  # Exibe o resultado formatado
end

if __FILE__ == $0
  # Verifica se o arquivo está sendo executado diretamente (não importado)

  main
  # Executa a função principal
end
