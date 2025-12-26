class Senha
  LETRAS = ("a".."z").to_a.join
  NUMEROS = ("0".."9").to_a.join
  PONTUACAO = "!#$%%&'()*+,-./:;<=>?@[\\]^_`{|}~"
  UNIR_TODOS = LETRAS + NUMEROS + PONTUACAO

  def initialize
    @app = ""
    @senha_final = ""
  end

  def set_nome_app(nome)
    @app = nome
  end

  def gerar_senha(tamanho)
    if tamanho <= 4
      puts "A senha precisa conter no mínimo 5 caracteres!"
      return nil
    end

    lista_senha = []

    lista_senha << LETRAS.chars.sample
    lista_senha << NUMEROS.chars.sample
    lista_senha << PONTUACAO.chars.sample

    (tamanho - 3).times do
      lista_senha << UNIR_TODOS.chars.sample
    end

    @senha_final = lista_senha.shuffle.join
    @senha_final
  end

  def gravar_senha
    begin
      File.open("não entre.txt", "a") do |f|
        f.puts "        Senhas para login        \n\n"
        f.puts "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=\n\n"
        f.puts "APP/Site: #{@app}\n\n"
        f.puts "Senha: #{@senha_final}\n\n"
        f.puts "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=\n\n\n\n"
      end
    rescue IOError => e
      puts "Erro ao gravar arquivo: #{e.message}"
    end
  end
end

puts "Digite o número de sites ou apps: "
nome_aplicativos = gets.chomp.to_i

s = Senha.new

nome_aplicativos.times do
  print "Digite o nome do app/site: "
  s.set_nome_app(gets.chomp)

  print "Digite o tamanho da senha: "
  comprimento = gets.chomp.to_i

  senha = s.gerar_senha(comprimento)
  
  if senha
    puts "Senha gerada com sucesso! Sua senha: #{senha}"
    s.gravar_senha
  end
end
