class Veiculo
  attr_accessor :marca, :modelo, :capacidade_passageiros, :velocidade_atual
  attr_reader :combustivel

  def initialize(marca, modelo, capacidade, combustivel = 100)
    @marca = marca
    @modelo = modelo
    @capacidade_passageiros = capacidade
    @combustivel = combustivel
    @velocidade_atual = 0
  end

  def acelerar(km_h)
    @velocidade_atual += km_h
    @combustivel -= (km_h * 0.1)
    puts "[#{@modelo}] Acelerando... Velocidade atual: #{@velocidade_atual} km/h."
  end

  def frear
    @velocidade_atual = 0
    puts "[#{@modelo}] O veículo parou."
  end

  def info
    puts "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+="
    puts "Tipo: #{self.class}"
    puts "Modelo: #{@marca} #{@modelo}"
    puts "Capacidade: #{@capacidade_passageiros} pessoas"
    puts "Combustível/Energia: #{@combustivel.round(2)}%"
  end
end


class Carro < Veiculo
  attr_accessor :num_portas

  def initialize(marca, modelo, capacidade, num_portas)
    super(marca, modelo, capacidade)
    @num_portas = num_portas
  end

  def abrir_porta_malas
    puts "Porta-malas do #{modelo} aberto."
  end
end

class Moto < Veiculo
  def initialize(marca, modelo)
    super(marca, modelo, 2)
  end

  def dar_grau
    puts "A moto #{modelo} está empinando! (Cuidado)"
  end
end

class Onibus < Veiculo
  def initialize(marca, modelo, capacidade)
    super(marca, modelo, capacidade)
  end

  def solicitar_parada
    puts "Campainha tocada. Próxima parada solicitada no ônibus #{modelo}."
  end
end

class Caminhao < Veiculo
  attr_accessor :carga_maxima

  def initialize(marca, modelo, carga_maxima)
    super(marca, modelo, 3)
    @carga_maxima = carga_maxima
  end

  def descarregar
    puts "Caminhão #{modelo} descarregando #{@carga_maxima} toneladas."
  end
end

class Bicicleta < Veiculo
  def initialize(marca, modelo)
    super(marca, modelo, 1, 0) 
  end

  def acelerar(km_h)
    @velocidade_atual += km_h
    puts "[Bike #{modelo}] Pedalando forte! Velocidade: #{@velocidade_atual} km/h."
    puts "Você está queimando calorias em vez de combustível!"
  end
end

# --- Subclasses de Veículos Ferroviários ---

class TremFerroviario < Veiculo
  def initialize(marca, modelo, num_vagoes)
    super(marca, modelo, num_vagoes * 40)
    @num_vagoes = num_vagoes
  end

  def apitar
    puts "CHUU-CHUU! O trem ferroviário #{modelo} está chegando."
  end
end

class Metro < TremFerroviario
  def initialize(linha, modelo)
    super("Metrô", modelo, 6)
    @linha = linha
  end

  def anunciar_estacao(nome_estacao)
    puts "Próxima estação da Linha #{@linha}: #{nome_estacao}."
  end
end

class Helicoptero < Veiculo
  def initialize(marca, modelo)
    super(marca, modelo, 6)
  end

  def decolar_verticalmente
    puts "Hélices girando... O helicóptero #{modelo} está subindo!"
    @velocidade_atual = 50
  end
end

class Navio < Veiculo
  def initialize(marca, modelo, tonelagem)
    super(marca, modelo, 2000)
    @tonelagem = tonelagem
  end

  def lancar_ancora
    puts "Navio #{@modelo} ancorado com sucesso em águas profundas."
  end
end

# --- Execução e Testes ---

frota = []

frota << Carro.new("Toyota", "Corolla", 5, 4)
frota << Moto.new("Honda", "CB 500")
frota << Onibus.new("Mercedes", "O500", 45)
frota << Caminhao.new("Scania", "R450", 30)
frota << Bicicleta.new("Caloi", "Elite")
frota << TremFerroviario.new("Alstom", "CargoTrain", 10)
frota << Metro.new("Azul", "Série 5000")
frota << Helicoptero.new("Robinson", "R44")
frota << Navio.new("Maersk", "Triple E", 165000)

puts "=== INICIANDO SIMULAÇÃO DE FROTA ==="

frota.each do |v|
  v.info
  v.acelerar(20)
  
  case v
  when Moto then v.dar_grau
  when Metro then v.anunciar_estacao("Consolação")
  when Caminhao then v.descarregar
  when Helicoptero then v.decolar_verticalmente
  when Bicicleta then puts "Saúde em dia!"
  end
end

puts "\n>>> FIM DA SIMULAÇÃO <<<"
