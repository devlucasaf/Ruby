class ClienteBanco

    @@no_of_cliente = 0
    # Variável de classe que conta quantos clientes foram criados

    def initialize(id, nome, data_nascimento, cpf, nacionalidade, genero, estado_civil, numero, email, profissao, salario, senha)
        # Método construtor que inicializa os atributos de cada cliente
        @cliente_id = id
        @cliente_nome = nome
        @cliente_data_nascimento = data_nascimento
        @cliente_cpf = cpf
        @cliente_nacionalidade = nacionalidade
        @cliente_genero = genero
        @cliente_estado_civil = estado_civil
        @cliente_numero = numero
        @cliente_email = email
        @cliente_profissao = profissao
        @cliente_salario = salario
        @cliente_senha = senha

        @@no_of_cliente += 1
        # Incrementa o contador de clientes sempre que um novo objeto é criado
    end

    # Método Get

=begin
    Para a criação do método Get e Set, podemos criar-la de duas formas:
    O 'attr_accessor' cria automaticamente os métodos Get e Set para você
    attr_accessor :nome, :cpf, :numero, :senha
    A segunda forma é da forma não comentada no código
=end

    # Métodos Get (acessores) que retornam os valores dos atributos
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
        # Retorna o CPF mascarado para proteger dados sensíveis
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
        # Retorna a senha mascarada para segurança
    end

    # +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
    # Método Set

    # Métodos Set (modificadores) que permitem alterar os atributos
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
        # Validação: CPF precisa ter exatamente 11 caracteres
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

    def alterar_numero(numero_atual, novo_numero)
        # Remove caracteres não numéricos dos números
        numero_atual_limpo = numero_atual.to_s.gsub(/\D/, "")
        novo_numero_limpo = novo_numero.to_s.gsub(/\D/, "")
        
        # Verifica se o número atual informado confere com o cadastrado
        if numero_atual_limpo != @cliente_numero
            puts "Erro: número atual incorreto!"
            return
        end
        
        # Valida se o novo número tem 11 dígitos (DDD + número)
        if novo_numero_limpo.length != 11
            raise ArgumentError, "O número precisa conter 11 dígitos (DDD + Número)!"
            return
        else
            @cliente_numero = novo_numero_limpo
            puts "Número atualizado com sucesso!"
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

    def alterar_senha(senha_atual, nova_senha)
        # Verifica se a senha atual informada está correta
        if senha_atual != @senha
            puts "Erro: senha atual incorreta!"
            return
        end
        
        # Valida se a nova senha tem pelo menos 6 caracteres
        if nova_senha.length < 6
            raise ArgumentError, "A senha precisa conter no mínimo 6 caracteres!"
            return
        else
            @senha = nova_senha
            puts "Senha atualizada com sucesso!"
        end
    end
    
    def self.total_clientes
        # Método de classe que retorna o total de clientes criados
        @@no_of_cliente
    end

    def mostrar_dados
        # Exibe todos os dados do cliente formatados
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
    # Criação de quatro clientes com dados fictícios
    cliente1 = ClienteBanco.new("1", "Jonas", "27/02/2001", 94525412156, "Brasileira", "Masculina", "Casado", 61994583652, "jonas.dev@email.com", "Desenvolvedor", 15674.39, "amoeba123")
    cliente2 = ClienteBanco.new("2", "Karla", "25/09/1986", 12345678136, "Portuguesa", "Feminino", "Solteira", 61999999999, "karla.maneira301@email.com", "Juíza", 37896.45, "amendoboboyeye0192")
    cliente3 = ClienteBanco.new("3", "Leanderson", "19/03/1875", 98765432845, "Brasileira", "Masculina", "Viúvo", 24988888888, "leandersongames5kill@email.com", "Gamer", 8932.67, "6titulos")
    cliente4 = ClienteBanco.new("4", "Samuel", "17/12/2004", 82165274869, "Brasileira", "Masculina", "Solteiro", 24977777777, "samuelino@email.com", "Futebolista", 543000.45, "lobisomenpidao1234")

    # Exibe os dados de todos os clientes
    cliente1.mostrar_dados
    cliente2.mostrar_dados
    cliente3.mostrar_dados
    cliente4.mostrar_dados

    # Teste de alteração de senha com senha correta
    puts "Tentando alterar senha com senha correta:"
    cliente1.alterar_senha("amoeba123", "@Jonaspapakill123")

    puts "\nDados atualizados com sucesso!"
    cliente1.mostrar_dados
    
    # Teste de alteração de número com número correto
    puts "Tentando alterar o número com o número correto:"
    cliente4.alterar_numero(24977777777, 24955555555)
end

main()
