class Senha
  # Classe responsável por gerar e gravar senhas seguras

  LETRAS = ("a".."z").to_a.join
  # Conjunto de letras minúsculas de 'a' até 'z'

  NUMEROS = ("0".."9").to_a.join
  # Conjunto de números de 0 a 9

  PONTUACAO = "!#$%%&'()*+,-./:;<=>?@[\\]^_`{|}~"
  # Conjunto de caracteres especiais (pontuação)

  UNIR_TODOS = LETRAS + NUMEROS + PONTUACAO
  # União de todos os caracteres possíveis para compor a senha

  def initialize
    # Inicializa atributos da classe
    @app = ""          # Nome do aplicativo/site associado à senha
    @senha_final = ""  # Senha gerada
  end

  def set_nome_app(nome)
    # Define o nome do aplicativo/site
    @app = nome
  end

  def gerar_senha(tamanho)
    # Gera uma senha aleatória com o tamanho especificado

    if tamanho <= 4
      # Validação: senha precisa ter pelo menos 5 caracteres
      puts "A senha precisa conter no mínimo 5 caracteres!"
      return nil
    end

    lista_senha = []
    # Lista que armazenará os caracteres da senha

    # Garante que a senha terá pelo menos uma letra, um número e um caractere especial
    lista_senha << LETRAS.chars.sample
    lista_senha << NUMEROS.chars.sample
    lista_senha << PONTUACAO.chars.sample

    # Preenche o restante da senha com caracteres aleatórios
    (tamanho - 3).times do
      lista_senha << UNIR_TODOS.chars.sample
    end

    # Embaralha os caracteres e junta em uma string final
    @senha_final = lista_senha.shuffle.join
    @senha_final
  end

  def gravar_senha
    # Grava a senha gerada em um arquivo de texto
    begin
      File.open("não entre.txt", "a") do |f|
        f.puts "        Senhas para login        \n\n"
        f.puts "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=\n\n"
        f.puts "APP/Site: #{@app}\n\n"
        f.puts "Senha: #{@senha_final}\n\n"
        f.puts "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=\n\n\n\n"
      end
    rescue IOError => e
      # Caso ocorra erro ao gravar no arquivo
      puts "Erro ao gravar arquivo: #{e.message}"
    end
  end
end

puts "Digite o número de sites ou apps: "
# Pergunta ao usuário quantos aplicativos/sites terão senhas geradas

nome_aplicativos = gets.chomp.to_i
# Lê o número de aplicativos/sites

s = Senha.new
# Cria uma instância da classe Senha

nome_aplicativos.times do
  # Loop para gerar senha para cada aplicativo/site informado

  print "Digite o nome do app/site: "
  s.set_nome_app(gets.chomp)
  # Define o nome do aplicativo/site

  print "Digite o tamanho da senha: "
  comprimento = gets.chomp.to_i
  # Lê o tamanho desejado da senha

  senha = s.gerar_senha(comprimento)
  # Gera a senha com o tamanho especificado

  if senha
    # Caso a senha seja válida (mínimo 5 caracteres)
    puts "Senha gerada com sucesso! Sua senha: #{senha}"
    s.gravar_senha
    # Grava a senha no arquivo
  end
end
