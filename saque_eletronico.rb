notas = [200, 100, 50, 20, 10, 5, 2]
qntd_nota_estoque = [50, 50, 50, 50, 50, 50, 50]
valor_total = 0

notas.each_with_index do |nota, i|
  valor_total += nota * qntd_nota_estoque[i]
end

puts "Nesse caixa, tem disponível: R$ #{'%.2f' % valor_total}"

loop do
  print "Digite quanto você quer sacar: "
  saque = gets.chomp.to_f

  if saque > valor_total
    puts "Saque indisponível! Valor maior do que disponível!"
    puts "O valor máximo para saque permitido neste terminal é de: R$ #{'%.2f' % valor_total}"
    next
  end

  resto = saque
  
  notas.each do |nota|
    if resto / nota >= 1
      qntd = (resto / nota).to_i
      resto -= (qntd * nota)
      puts "A quantidade de notas de R$ #{nota} é de: #{qntd} notas"
    end
  end

  valor_total -= saque
  puts "Neste caixa tem R$ #{'%.2f' % valor_total} em notas de #{notas}"

  if valor_total <= 0
    puts "Você conseguiu estourar o caixa"
    break
  end

  print "Deseja realizar um novo saque? Sim/Não: "
  new_saque = gets.chomp.strip.upcase
  
  break if new_saque == "NAO"
end
