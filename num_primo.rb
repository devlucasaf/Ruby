def eh_primo(num)
  return false if num <= 1

  (2..Math.sqrt(num)).each do |i|

    if num % i == 0
      return false 
    end
  end

  return true
end

print "Digite um número inteiro: "

numero = gets.chomp.to_i

if eh_primo?(numero)
  puts "#{numero} é um número primo."
else
  puts "#{numero} não é um número primo."
end
