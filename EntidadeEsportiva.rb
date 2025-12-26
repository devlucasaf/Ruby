class EntidadeEsportiva
  attr_accessor :nome, :fundacao, :sede
  attr_reader :vitorias, :status

  def initialize(nome, fundacao, sede)
    @nome = nome
    @fundacao = fundacao
    @sede = sede
    @vitorias = 0
    @status = "Inativo"
  end

  def registrar_vitoria
    @vitorias += 1
    puts "O #{@nome} conquistou mais uma vitória!"
  end

  def alterar_status(novo_status)
    @status = novo_status
    puts "Status do #{@nome} alterado para: #{@status}"
  end
end

class ClubeFutebol < EntidadeEsportiva
  attr_accessor :estadio, :orcamento

  def initialize(nome, fundacao, sede, estadio, orcamento)
    super(nome, fundacao, sede)
    @estadio = estadio
    @orcamento = orcamento
  end

  def realizar_treino
    puts "O clube #{@nome} iniciou o treino coletivo no gramado."
  end
end

class TimeProfissional < ClubeFutebol
  def initialize(nome, fundacao, sede, estadio, orcamento, divisao)
    super(nome, fundacao, sede, estadio, orcamento)
    @divisao = divisao
  end

  def contratar_jogador(nome_jogador, valor)
    if valor <= @orcamento
      @orcamento -= valor
      puts "#{@nome} contratou #{nome_jogador} pela quantia de R$ #{valor}."
    else
      puts "Orcamento insuficiente para contratar #{nome_jogador}."
    end
  end
end

class TimeJunior < ClubeFutebol
  def initialize(nome, fundacao, sede, estadio, idade_maxima)
    super(nome, fundacao, sede, estadio, 0)
    @idade_maxima = idade_maxima
  end

  def promover_atleta(atleta)
    puts "O atleta #{atleta} foi promovido da base do #{@nome} para o profissional."
  end
end

class SelecaoNacional < EntidadeEsportiva
  attr_accessor :pais, :continente

  def initialize(nome, fundacao, pais, continente)
    super(nome, fundacao, pais)
    @pais = pais
    @continente = continente
  end

  def convocar_jogadores(lista)
    puts "A Seleção de #{@pais} convocou: #{lista.join(', ')}."
  end
end

class TimeFeminino < ClubeFutebol
  def initialize(nome, fundacao, sede, estadio, orcamento)
    super(nome, fundacao, sede, estadio, orcamento)
  end

  def disputar_libertadores
    puts "O time feminino do #{@nome} está entrando em campo pela Libertadores."
  end
end

class TimeMaster < ClubeFutebol
  def initialize(nome, fundacao, sede, estadio)
    super(nome, fundacao, sede, estadio, 0)
  end

  def organizar_amistoso_beneficente
    puts "O time Master do #{@nome} organizou um jogo para caridade."
  end
end

class TimeFutsal < ClubeFutebol
  def initialize(nome, fundacao, sede, ginasio)
    super(nome, fundacao, sede, ginasio, 500000)
  end

  def pedir_tempo
    puts "O técnico do futsal do #{@nome} pediu tempo técnico."
  end
end

class TimeAmador < EntidadeEsportiva
  def initialize(nome, sede)
    super(nome, Time.now.year, sede)
  end

  def churrasco_pos_jogo
    puts "Fim de jogo para o #{@nome}. Hora do churrasco da comunidade!"
  end
end

class TimeEsportsFutebol < EntidadeEsportiva
  def initialize(nome, fundacao, plataforma)
    super(nome, fundacao, "Digital")
    @plataforma = plataforma
  end

  def atualizar_firmware
    puts "O time de e-sports #{@nome} está atualizando os equipamentos."
  end
end

times = [
  TimeProfissional.new("Flamengo", 1895, "Rio de Janeiro", "Maracanã", 500000000, "Série A"),
  SelecaoNacional.new("Canarinho", 1914, "Brasil", "América do Sul"),
  TimeJunior.new("Crias da Academia", 1914, "São Paulo", "CT Barra Funda", 20),
  TimeFeminino.new("Corinthians Feminino", 1910, "São Paulo", "Neo Química Arena", 20000000),
  TimeEsportsFutebol.new("Netshoes Miners", 2020, "PC/Console"),
  TimeAmador.new("Vila do Tanque FC", "Belo Horizonte")
]

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
