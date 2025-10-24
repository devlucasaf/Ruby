# Função que imprime uma linha divisória
def linha
  puts "=+=+" * 69
end

# Loop principal do programa
loop do
  print "Digite quanto você ganha por mês: "
  salario = gets.chomp.to_f

  print "Digite [Sim] para caso você pague o sindicato ou [Não] para caso você não pague o sindicato: "
  sindicato = gets.chomp.upcase

  # Calcula o salário anual
  ano = salario * 12
  puts "Você recebe por ano: R$ #{'%.2f' % ano}"

  # Verifica a faixa salarial e calcula os descontos
  if salario <= 2112
    # Primeira faixa - isento de IR
    if sindicato == "SIM"
      valor_sindicato = salario * 0.05
      inss = salario * 0.11
      desconto = valor_sindicato + inss
      liquido = salario - desconto
      puts "Você paga ao sindicato: R$ #{'%.2f' % valor_sindicato}"
      puts "Você não paga imposto de renda"
      puts "Você paga de INSS: R$ #{'%.2f' % inss}"
      puts "É descontado do seu salário: R$ #{'%.2f' % desconto}"
      puts "Seu salário líquido é: R$ #{'%.2f' % liquido}"
      break
    elsif sindicato == "NAO"
      inss = salario * 0.11
      desconto = inss
      liquido = salario - desconto
      puts "Você não paga imposto de renda"
      puts "Você paga de INSS: R$ #{'%.2f' % inss}"
      puts "É descontado do seu salário: R$ #{'%.2f' % desconto}"
      puts "Seu salário líquido é: R$ #{'%.2f' % liquido}"
      break
    else
      puts "Palavra digitada não aceita!"
    end

  elsif salario <= 2826.55
    # Segunda faixa - 7.5%
    imposto = salario * 0.075
    inss = salario * 0.11
    if sindicato == "SIM"
      valor_sindicato = salario * 0.05
      desconto = imposto + inss + valor_sindicato
      liquido = salario - desconto
      puts "Você paga ao sindicato: R$ #{'%.2f' % valor_sindicato}"
    else
      desconto = imposto + inss
      liquido = salario - desconto
    end
    puts "Você paga de imposto de renda: R$ #{'%.2f' % imposto}"
    puts "Você paga de INSS: R$ #{'%.2f' % inss}"
    puts "É descontado do seu salário: R$ #{'%.2f' % desconto}"
    puts "Seu salário líquido é: R$ #{'%.2f' % liquido}"
    break

  elsif salario <= 3751.05
    # Terceira faixa - 15%
    imposto = salario * 0.15
    inss = salario * 0.11
    if sindicato == "SIM"
      valor_sindicato = salario * 0.05
      desconto = imposto + inss + valor_sindicato
      liquido = salario - desconto
      puts "Você paga ao sindicato: R$ #{'%.2f' % valor_sindicato}"
    else
      desconto = imposto + inss
      liquido = salario - desconto
    end
    puts "Você paga de imposto de renda: R$ #{'%.2f' % imposto}"
    puts "Você paga de INSS: R$ #{'%.2f' % inss}"
    puts "É descontado do seu salário: R$ #{'%.2f' % desconto}"
    puts "Seu salário líquido é: R$ #{'%.2f' % liquido}"
    break

  elsif salario <= 4664.68
    # Quarta faixa - 22.5%
    imposto = salario * 0.225
    inss = salario * 0.11
    if sindicato == "SIM"
      valor_sindicato = salario * 0.05
      desconto = imposto + inss + valor_sindicato
      liquido = salario - desconto
      puts "Você paga ao sindicato: R$ #{'%.2f' % valor_sindicato}"
    else
      desconto = imposto + inss
      liquido = salario - desconto
    end
    puts "Você paga de imposto de renda: R$ #{'%.2f' % imposto}"
    puts "Você paga de INSS: R$ #{'%.2f' % inss}"
    puts "É descontado do seu salário: R$ #{'%.2f' % desconto}"
    puts "Seu salário líquido é: R$ #{'%.2f' % liquido}"
    break

  else
    # Quinta faixa - 27.5%
    imposto = salario * 0.275
    inss = salario * 0.11
    if sindicato == "SIM"
      valor_sindicato = salario * 0.05
      desconto = imposto + inss + valor_sindicato
      liquido = salario - desconto
      puts "Você paga ao sindicato: R$ #{'%.2f' % valor_sindicato}"
    else
      desconto = imposto + inss
      liquido = salario - desconto
    end
    puts "Você paga de imposto de renda: R$ #{'%.2f' % imposto}"
    puts "Você paga de INSS: R$ #{'%.2f' % inss}"
    puts "É descontado do seu salário: R$ #{'%.2f' % desconto}"
    puts "Seu salário líquido é: R$ #{'%.2f' % liquido}"
    break
  end
end
