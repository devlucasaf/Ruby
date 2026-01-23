class EntidadeEsportiva
  # Classe base para entidades esportivas (clubes, seleções, times etc.)
  attr_accessor :nome, :fundacao, :sede
  attr_reader :vitorias, :status

  def initialize(nome, fundacao, sede)
    # Inicializa atributos básicos da entidade esportiva
    @nome = nome
    @fundacao = fundacao
    @sede = sede
    @vitorias = 0
    @status = "Inativo"
  end

  def registrar_vitoria
    # Incrementa o número de vitórias e exibe mensagem
    @vitorias += 1
    puts "O #{@nome} conquistou mais uma vitória!"
  end

  def alterar_status(novo_status)
    # Altera o status da entidade (ex: Em Competição, Inativo)
    @status = novo_status
    puts "Status do #{@nome} alterado para: #{@status}"
  end
end

class ClubeFutebol < EntidadeEsportiva
  # Classe que herda de EntidadeEsportiva e adiciona atributos específicos de clubes de futebol
  attr_accessor :estadio, :orcamento

  def initialize(nome, fundacao, sede, estadio, orcamento)
    super(nome, fundacao, sede)
    @estadio = estadio
    @orcamento = orcamento
  end

  def realizar_treino
    # Simula a realização de um treino
    puts "O clube #{@nome} iniciou o treino coletivo no gramado."
  end
end

class TimeProfissional < ClubeFutebol
  # Representa um time profissional de futebol
  def initialize(nome, fundacao, sede, estadio, orcamento, divisao)
    super(nome, fundacao, sede, estadio, orcamento)
    @divisao = divisao
  end

  def contratar_jogador(nome_jogador, valor)
    # Simula contratação de jogador, verificando orçamento disponível
    if valor <= @orcamento
      @orcamento -= valor
      puts "#{@nome} contratou #{nome_jogador} pela quantia de R$ #{valor}."
    else
      puts "Orcamento insuficiente para contratar #{nome_jogador}."
    end
  end
end

class TimeJunior < ClubeFutebol
  # Representa um time de base (juniores)
  def initialize(nome, fundacao, sede, estadio, idade_maxima)
    super(nome, fundacao, sede, estadio, 0)
    @idade_maxima = idade_maxima
  end

  def promover_atleta(atleta)
    # Simula promoção de atleta da base para o profissional
    puts "O atleta #{atleta} foi promovido da base do #{@nome} para o profissional."
  end
end

class SelecaoNacional < EntidadeEsportiva
  # Representa uma seleção nacional de futebol
  attr_accessor :pais, :continente

  def initialize(nome, fundacao, pais, continente)
    super(nome, fundacao, pais)
    @pais = pais
    @continente = continente
  end

  def convocar_jogadores(lista)
    # Simula convocação de jogadores para a seleção
    puts "A Seleção de #{@pais} convocou: #{lista.join(', ')}."
  end
end

class TimeFeminino < ClubeFutebol
  # Representa um time feminino de futebol
  def initialize(nome, fundacao, sede, estadio, orcamento)
    super(nome, fundacao, sede, estadio, orcamento)
  end

  def disputar_libertadores
    # Simula participação na Libertadores
    puts "O time feminino do #{@nome} está entrando em campo pela Libertadores."
  end
end

class TimeMaster < ClubeFutebol
  # Representa um time master (veteranos)
  def initialize(nome, fundacao, sede, estadio)
    super(nome, fundacao, sede, estadio, 0)
  end

  def organizar_amistoso_beneficente
    # Simula organização de amistoso beneficente
    puts "O time Master do #{@nome} organizou um jogo para caridade."
  end
end

class TimeFutsal < ClubeFutebol
  # Representa um time de futsal
  def initialize(nome, fundacao, sede, ginasio)
    super(nome, fundacao, sede, ginasio, 500000)
  end

  def pedir_tempo
    # Simula pedido de tempo técnico
    puts "O técnico do futsal do #{@nome} pediu tempo técnico."
  end
end

class TimeAmador < EntidadeEsportiva
  # Representa um time amador
  def initialize(nome, sede)
    super(nome, Time.now.year, sede)
  end

  def churrasco_pos_jogo
    # Simula confraternização após jogo
    puts "Fim de jogo para o #{@nome}. Hora do churrasco da comunidade!"
  end
end

class TimeEsportsFutebol < EntidadeEsportiva
  # Representa um time de e-sports de futebol digital
  def initialize(nome, fundacao, plataforma)
    super(nome, fundacao, "Digital")
    @plataforma = plataforma
  end

  def atualizar_firmware
    # Simula atualização de equipamentos digitais
    puts "O time de e-sports #{@nome} está atualizando os equipamentos."
  end
end

# Criação de instâncias de diferentes tipos de entidades esportivas
times = [
  TimeProfissional.new("Flamengo", 1895, "Rio de Janeiro", "Maracanã", 500000000, "Série A"),
  SelecaoNacional.new("Canarinho", 1914, "Brasil", "América do Sul"),
  TimeJunior.new("Crias da Academia", 1914, "São Paulo", "CT Barra Funda", 20),
  TimeFeminino.new("Corinthians Feminino", 1910, "São Paulo", "Neo Química Arena", 20000000),
  TimeEsportsFutebol.new("Netshoes Miners", 2020, "PC/Console"),
  TimeAmador.new("Vila do Tanque FC", "Belo Horizonte")
]

# Itera sobre cada entidade e executa ações específicas
times.each do |t|
  puts "Entidade: #{t.nome} (Sede: #{t.sede})"
  t.alterar_status("Em Competição")
  
  case t
  when TimeProfissional then t.contratar_jogador("Gabigol", 15000000)
  when SelecaoNacional then t.convocar_jogadores(["Vinícius Jr", "Alisson"])
  when TimeJunior then t.promover_atleta("Endrick")
  when TimeFeminino then t.disputar_libertadores
  when TimeEsportsFutebol then t.atualizar_firmware
  when TimeAmador then t.churrasco_pos_jogo
  end
  
  t.registrar_vitoria
  puts "---"
end
