def eh_primo(num)
  # Função que verifica se um número é primo

  return false if num <= 1
  # Números menores ou iguais a 1 não são primos

  (2..Math.sqrt(num)).each do |i|
    # Itera de 2 até a raiz quadrada do número
    # Se algum divisor for encontrado nesse intervalo, o número não é primo

    if num % i == 0
      # Se o resto da divisão for zero, significa que 'i' é divisor de 'num'
      return false 
    end
  end

  return true
  # Se nenhum divisor foi encontrado, o número é primo
end

print "Digite um número inteiro: "
# Solicita ao usuário que digite um número

numero = gets.chomp.to_i
# Lê o número digitado, remove espaços e converte para inteiro

if eh_primo(numero)
  puts "#{numero} é um número primo."
else
  puts "#{numero} não é um número primo."
end

