def calcular_seno(angulo)
  rad = angulo * 3.14 / 180
  puts rad
  seno = 0.0
  n = 0

  loop do
    exponencial = (2 * n + 1)
    numerador = ((-1) ** n) * (rad ** exponencial)
    denominador = (1..(2 * n + 1)).inject(:*) 

    termo = numerador.to_f / denominador

    break if termo.abs < 0.0001

    seno += termo
    n += 1
  end

  return seno
end

def main
  print "Ângulo em graus: "
  angulo = gets.to_f

  seno = calcular_seno(angulo)
  puts "O seno de #{angulo} graus = #{seno}"
end

if __FILE__ == $0
  main
end
