# linguagem: ruby

# Definição de variáveis para cores no terminal usando códigos ANSI
blue  = "\e[1;34m"   # Azul
red   = "\e[1;31m"   # Vermelho
yellow= "\e[1;33m"   # Amarelo
green = "\e[1;32m"   # Verde
nc    = "\e[0m"      # Reset (sem cor)

# Lista de opções possíveis no jogo
opcoes = %w[pedra papel tesoura]

# Hash que define quais opções vencem de quais
# Exemplo: pedra vence tesoura, tesoura vence papel, papel vence pedra
vences = { 'pedra' => 'tesoura', 'tesoura' => 'papel', 'papel' => 'pedra' }

def jogo(opcoes, vences, blue, red, yellow, green, nc)
  # Função principal que executa uma rodada do jogo
  
  puts "#{blue}Escolha uma opção:
  [1] Pedra
  [2] Papel
  [3] Tesoura#{nc}"
  # Exibe menu de opções com cor azul

  escolha = gets.to_i
  # Lê a escolha do usuário e converte para inteiro

  unless (1..3).include?(escolha)
    # Valida se a escolha está entre 1 e 3
    puts "#{red}Opção inválida!#{nc}"
    return
  end

  usuario = opcoes[escolha - 1]
  # Define a jogada do usuário com base na escolha

  pc = opcoes.sample
  # Escolha aleatória do computador

  if pc == usuario
    # Caso empate
    puts "#{green}O pc escolheu #{pc} — vocês empataram!#{nc}"
  elsif vences[usuario] == pc
    # Caso o usuário vença
    puts "#{blue}Você ganhou do computador! O computador escolheu #{pc}#{nc}"
  else
    # Caso o usuário perca
    puts "#{red}Você perdeu! O computador escolheu #{pc}#{nc}"
  end
end

# primeira execução do jogo
jogo(opcoes, vences, blue, red, yellow, green, nc)

loop do
  # Loop para perguntar se o usuário deseja jogar novamente
  print "Você deseja jogar novamente? Digite [SIM] para continuar ou [NAO] para parar o jogo: "
  jogar = gets.to_s.strip.upcase
  # Lê a resposta do usuário, remove espaços e converte para maiúsculas

  case jogar
  when "SIM"
    # Se o usuário digitar SIM, roda novamente o jogo
    jogo(opcoes, vences, blue, red, yellow, green, nc)
  when "NAO"
    # Se digitar NAO, encerra o loop e o programa
    break
  else
    # Caso digite algo diferente de SIM ou NAO
    puts "Palavra não aceita! Digite [SIM] para continuar ou [NAO] para parar o jogo!"
  end
end
