# linguagem: ruby
blue  = "\e[1;34m"
red   = "\e[1;31m"
yellow= "\e[1;33m"
green = "\e[1;32m"
nc    = "\e[0m"

opcoes = %w[pedra papel tesoura]
vences = { 'pedra' => 'tesoura', 'tesoura' => 'papel', 'papel' => 'pedra' }

def jogo(opcoes, vences, blue, red, yellow, green, nc)
  puts "#{blue}Escolha uma opção:
  [1] Pedra
  [2] Papel
  [3] Tesoura#{nc}"

  escolha = gets.to_i
  unless (1..3).include?(escolha)
    puts "#{red}Opção inválida!#{nc}"
    return
  end

  usuario = opcoes[escolha - 1]
  pc = opcoes.sample

  if pc == usuario
    puts "#{green}O pc escolheu #{pc} — vocês empataram!#{nc}"
  elsif vences[usuario] == pc
    puts "#{blue}Você ganhou do computador! O computador escolheu #{pc}#{nc}"
  else
    puts "#{red}Você perdeu! O computador escolheu #{pc}#{nc}"
  end
end

# primeira execução
jogo(opcoes, vences, blue, red, yellow, green, nc)

loop do
  print "Você deseja jogar novamente? Digite [SIM] para continuar ou [NAO] para parar o jogo: "
  jogar = gets.to_s.strip.upcase
  case jogar
  when "SIM"
    jogo(opcoes, vences, blue, red, yellow, green, nc)
  when "NAO"
    break
  else
    puts "Palavra não aceita! Digite [SIM] para continuar ou [NAO] para parar o jogo!"
  end
end
