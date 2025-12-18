# frozen_string_literal: true

=begin
  Código de Sistema de um Elevador
  Código original desenvolvido em python por @DediXt04
  https://github.com/DediXt04/Elevator link para conferirem o código original
=end

class Elevador
  def initialize(total_andares = 100)
    @total_andares = total_andares
    @andar_atual = 0
    @passageiros = []
    @chamadas = []
    @movimentos = 0
  end

  def adicionar_chamada(passageiro)
    unless (0...@total_andares).include?(passageiro.andar_origem) &&
           (0...@total_andares).include?(passageiro.andar_destino)
      return
    end

    @chamadas << passageiro
    puts "📞 Chamada: #{passageiro.andar_origem} -> #{passageiro.andar_destino}"
  end

  def escolher_destino
    destinos = []

    @passageiros.each { |p| destinos << p.andar_destino }
    @chamadas.each   { |p| destinos << p.andar_origem }

    return nil if destinos.empty?

    destinos.min_by { |x| (x - @andar_atual).abs }
  end

  def mover
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
      puts "🚪 Chegou no andar #{@andar_atual}"

      entrou_pessoa = false
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
      @passageiros.clone.each do |p|
        if p.andar_destino == @andar_atual
          p.no_elevador = false
          @passageiros.delete(p)
          saiu_pessoa = true
          puts "⬇️ Saiu: #{p}"
        end
      end

      puts "🕓 Sem embarque/desembarque neste andar." if !entrou_pessoa && !saiu_pessoa
    end
  end

  def status
    puts "🏢 Andar atual: #{@andar_atual}"
    puts "📞 Chamadas: #{@chamadas.empty? ? '—' : @chamadas}"
    puts "🛗 Passageiros: #{@passageiros.empty? ? '—' : @passageiros}"
    puts "-" * 40
  end
end

class Passageiro
  attr_accessor :andar_origem, :andar_destino, :no_elevador

  def initialize(andar_origem, andar_destino)
    @andar_origem = andar_origem
    @andar_destino = andar_destino
    @no_elevador = false
  end

  def to_s
    estado = @no_elevador ? "🟢" : "⚪"
    "#{estado}👤(#{@andar_origem}->#{@andar_destino})"
  end
end

TOTAL_ANDARES = 100
elevador = Elevador.new(TOTAL_ANDARES)

passageiros = []

100.times do
  origem = rand(0...TOTAL_ANDARES)
  destino = rand(0...TOTAL_ANDARES)
  destino = rand(0...TOTAL_ANDARES) while destino == origem

  passageiros << Passageiro.new(origem, destino)
end

passageiros.each { |p| elevador.adicionar_chamada(p) }
