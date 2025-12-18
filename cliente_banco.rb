class ClienteBanco

  @@no_of_cliente = 0
  def  initialize(id, nome, data_nascimento, cpf, nacionalidade, genero, estado_civil, numero, email, profissao, salario, senha)
    @cliente_id = id
    @cliente_nome = nome
    @cliente_data_nascimento = data_nascimento
    @cliente_nacionalidade = nacionalidade
    @cliente_genero = genero
    @cliente_estado_civil = estado_civil
    @cliente_email = email
    @cliente_profissao = profissao
    @cliente_salario = salario

    self.numero = numero
    self.cpf = cpf
    self.senha = senha

    @@no_of_cliente += 1
  end

  # Método Get

=begin
  Para a criação do método Get e Set, podemos criar-la de duas formas:
    O 'attr_accessor' cria automaticamente os métodos Get e Set para você
    attr_accessor :nome, :cpf, :numero, :senha
  A segunda forma é da forma não comentada no código
=end

  def id
    @cliente_id
  end

  def nome
    @cliente_nome
  end

  def data_nascimento
    @cliente_data_nascimento
  end

  def cpf
    "***********"
  end

  def nacionalidade
    @cliente_nacionalidade
  end

  def genero
    @cliente_genero
  end

  def estado_civil
    @cliente_estado_civil
  end

  def numero
    @cliente_numero
  end

  def email
    @cliente_email
  end

  def profissao
    @cliente_profissao
  end

  def salario
    @cliente_salario
  end

  def senha
    "******"
  end

# +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=

  # Método Set

  def id=(id)
    @cliente_id = id
  end

  def nome=(nome)
    @cliente_nome = nome
  end

  def data_nascimento=(data_nascimento)
    @cliente_data_nascimento = data_nascimento
  end

  def cpf=(valor)
    if valor.to_s.strip.length != 11
      raise ArgumentError, "O CPF precisa conter 11 caracteres"
    else
      @cliente_cpf = valor
    end
  end

  def nacionalidade=(nacionalidade)
    @cliente_nacionalidade = nacionalidade
  end

  def genero=(valor)
    @cliente_genero = valor
  end

  def estado_civil=(estado_civil)
    @cliente_estado_civil = estado_civil
  end

  def numero=(valor)
    if valor.to_s.strip.length != 11
      raise ArgumentError, "O número celular precisa conter 11 números! (DDD + Número)"
    else
      @cliente_numero = valor
    end
  end

  def numero=(novo_numero)
    # Remove tudo que não é número (pontos, traços, parênteses)
    numero_limpo = novo_numero.to_s.gsub(/\D/, "")

    if numero_limpo.length != 11
      raise ArgumentError, "O número precisa de 11 dígitos (DDD + Número)"
    else
      @cliente_numero = numero_limpo
    end
  end

  def email=(email)
    @cliente_email = email
  end

  def profissao=(profissao)
    @cliente_profissao = profissao
  end

  def salario=(salario)
    @cliente_salario = salario
  end

  def senha=(nova_senha)
    if nova_senha.length < 6
      puts "Erro: A senha deve ter no mínimo 6 caracteres!"
    else
      @senha = nova_senha
      puts "Senha alterada com sucesso!"
    end
  end

  def self.total_clientes
    @@no_of_cliente
  end

  def mostrar_dados
    puts "+=+= " + ("+=+="*69) + "\n"
    puts "ID: #{@cliente_id}"
    puts "Nome: #{@cliente_nome}"
    puts "Data de Nascimento: #{@cliente_data_nascimento}"
    puts "CPF: #{@cliente_cpf}"
    puts "Nacionalidade: #{@cliente_nacionalidade}"
    puts "Gênero: #{@cliente_genero}"
    puts "Estado Cívil: #{@cliente_estado_civil}"
    puts "Número: #{@cliente_numero}"
    puts "E-mail: #{@cliente_email}"
    puts "Profissao: #{@cliente_profissao}"
    puts "Salario: R$ #{@cliente_salario}"
    puts "Senha: #{@senha}\n"
    puts "+=+= " + ("+=+="*69) + "\n"
  end
end

def main()
  cliente1 = ClienteBanco.new("1",
                              "Jonas",
                              "27/02/2001",
                              "945.254.121-56",
                              "Brasileira",
                              "Masculina",
                              "Casado",
                              61994583652,
                              "jonas.dev@email.com",
                              "Desenvolvedor",
                              "15674,39",
                              "amoeba123")
  cliente2 = ClienteBanco.new("2",
                              "Karla",
                              "25/09/1986",
                              "123.456.781-36",
                              "Portuguesa",
                              "Feminino",
                              "Solteira",
                              61999999999,
                              "karla.maneira301@email.com",
                              "Juíza",
                              "37896,45",
                              "amendoboboyeye0192")
  cliente3 = ClienteBanco.new("3",
                              "Leanderson",
                              "19/03/1875",
                              "987.654.328-45",
                              "Brasileira",
                              "Masculina",
                              "Viúvo",
                              24988888888,
                              "leandersongames5kill@email.com",
                              "Gamer",
                              "8932,67",
                              "6titulos")

  cliente1.mostrar_dados
  cliente2.mostrar_dados
  cliente3.mostrar_dados

  puts "Tentando alterar senha com senha correta:"
  cliente1.senha("amoeba123", "@Jonaspapakill123")

  puts "\nDados atualizados com sucesso!"
  cliente1.mostrar_dados
end

main()
