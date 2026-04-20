# frozen_string_literal: true
# Congela literais de string para otimização de memória e performance

=begin
  Código de Sistema de um Elevador
  Código original desenvolvido em python por @DediXt04
  https://github.com/DediXt04/Elevator link para conferirem o código original
=end

class Elevador
  def initialize(total_andares = 100)
    # Inicializa o elevador com número total de andares (padrão: 100)
    @total_andares = total_andares
    @andar_atual = 0          # Elevador começa no térreo (andar 0)
    @passageiros = []         # Lista de passageiros dentro do elevador
    @chamadas = []            # Lista de chamadas (passageiros esperando)
    @movimentos = 0           # Contador de movimentos realizados
  end

  def adicionar_chamada(passageiro)
    # Adiciona uma chamada ao elevador, validando se origem e destino são válidos
    unless (0...@total_andares).include?(passageiro.andar_origem) &&
            (0...@total_andares).include?(passageiro.andar_destino)
      return
    end

    @chamadas << passageiro
    puts "📞 Chamada: #{passageiro.andar_origem} -> #{passageiro.andar_destino}"
  end

  def escolher_destino
    # Escolhe o próximo destino com base nos passageiros e chamadas
    destinos = []

    @passageiros.each { |p| destinos << p.andar_destino }
    @chamadas.each   { |p| destinos << p.andar_origem }

    return nil if destinos.empty?

    # Seleciona o destino mais próximo do andar atual
    destinos.min_by { |x| (x - @andar_atual).abs }
  end

  def mover
    # Move o elevador em direção ao próximo destino
    destino = escolher_destino

    if destino.nil?
      puts "⏸ Nenhuma chamada ou passageiro no momento."
      return
    end

    if @andar_atual < destino
      @andar_atual += 1
      @movimentos += 1
      puts "🔼 Subiu para #{@andar_atual}"

    elsif @andar_atual > destino
      @andar_atual -= 1
      @movimentos += 1
      puts "🔽 Desceu para #{@andar_atual}"

    else
      # Caso o elevador esteja no andar do destino
      puts "🚪 Chegou no andar #{@andar_atual}"

      entrou_pessoa = false
      # Verifica se alguém entra no elevador neste andar
      @chamadas.clone.each do |p|
        if p.andar_origem == @andar_atual
          p.no_elevador = true
          @passageiros << p
          @chamadas.delete(p)
          entrou_pessoa = true
          puts "⬆️ Entrou: #{p}"
        end
      end

      saiu_pessoa = false
      # Verifica se alguém sai do elevador neste andar
      @passageiros.clone.each do |p|
        if p.andar_destino == @andar_atual
          p.no_elevador = false
          @passageiros.delete(p)
          saiu_pessoa = true
          puts "⬇️ Saiu: #{p}"
        end
      end

      # Caso não haja embarque ou desembarque
      puts "🕓 Sem embarque/desembarque neste andar." if !entrou_pessoa && !saiu_pessoa
    end
  end

  def status
    # Exibe o status atual do elevador
    puts "🏢 Andar atual: #{@andar_atual}"
    puts "📞 Chamadas: #{@chamadas.empty? ? '—' : @chamadas}"
    puts "🛗 Passageiros: #{@passageiros.empty? ? '—' : @passageiros}"
    puts "-" * 40
  end
end

class Passageiro
  # Define atributos acessíveis para origem, destino e estado (se está no elevador)
  attr_accessor :andar_origem, :andar_destino, :no_elevador

  def initialize(andar_origem, andar_destino)
    # Inicializa passageiro com andar de origem e destino
    @andar_origem = andar_origem
    @andar_destino = andar_destino
    @no_elevador = false
  end

  def to_s
    # Representação textual do passageiro com ícone de estado
    estado = @no_elevador ? "🟢" : "⚪"
    "#{estado}👤(#{@andar_origem}->#{@andar_destino})"
  end
end

TOTAL_ANDARES = 100
# Define o total de andares do prédio
elevador = Elevador.new(TOTAL_ANDARES)
# Cria uma instância do elevador

passageiros = []
# Lista de passageiros simulados

100.times do
  # Cria 100 passageiros com origem e destino aleatórios
  origem = rand(0...TOTAL_ANDARES)
  destino = rand(0...TOTAL_ANDARES)
  destino = rand(0...TOTAL_ANDARES) while destino == origem
  # Garante que destino seja diferente da origem

  passageiros << Passageiro.new(origem, destino)
end

# Adiciona todos os passageiros como chamadas ao elevador
passageiros.each { |p| elevador.adicionar_chamada(p) }
