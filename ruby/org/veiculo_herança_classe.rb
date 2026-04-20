# Código desenvolvido por Lucas Freitas a fim de estudos
# Herança em Ruby - Classe Veículo
# Conversão do seu código Java para Ruby

class CoresHexadecimaisTerminal
  RESET = "\e[0m"

  def self.cor_hexadecimal(r, g, b)
    "\e[38;2;#{r};#{g};#{b}m"
  end

  WHITE        = cor_hexadecimal(255, 250, 250) # 1
  LEMON_CHIFFON = cor_hexadecimal(255, 250, 205) # 2
  ROYAL_BLUE   = cor_hexadecimal(65, 105, 225)  # 3
  AQUA_MARINE  = cor_hexadecimal(127, 255, 212) # 4
  GOLD         = cor_hexadecimal(255, 215, 0)   # 5
  FOREST_GREEN = cor_hexadecimal(34, 139, 34)   # 6
  SPRING_GREEN = cor_hexadecimal(0, 255, 127)   # 7
  CYAN         = cor_hexadecimal(0, 255, 255)   # 8
  BEIGE        = cor_hexadecimal(245, 245, 220) # 9
  FIRE_BRICK   = cor_hexadecimal(178, 34, 34)   # 10
  RED          = cor_hexadecimal(255, 0, 0)     # 11
  DARK_VIOLET  = cor_hexadecimal(148, 0, 211)   # 12
  DEEP_SKY_BLUE = cor_hexadecimal(0, 191, 255)  # 13
  DODGER_BLUE  = cor_hexadecimal(24, 116, 205)  # 14
  SLATE_BLUE   = cor_hexadecimal(71, 60, 139)   # 15
  TOMATO       = cor_hexadecimal(255, 99, 71)   
end

class VeiculoAutoMovel
  @@contador_veiculos = 0

  attr_reader :marca, :modelo, :preco, :km, :ano_lancamento, :velocidade, :numero_veiculo

  def initialize(marca, modelo, preco, km, ano_lancamento, velocidade)
    @marca = marca
    @modelo = modelo
    @preco = preco
    @km = km
    @ano_lancamento = ano_lancamento
    @velocidade = velocidade

    @@contador_veiculos += 1
    @numero_veiculo = @@contador_veiculos
  end

  def acelerar(incremento)
    @velocidade += incremento if incremento > 0
  end

  def frear(reducao)
    if reducao > 0 && (@velocidade - reducao) >= 0
      @velocidade -= reducao
    end
  end

  def mostrar_dados
    cor = CoresHexadecimaisTerminal.cor_hexadecimal(
      (@numero_veiculo * 40) % 255,
      (@numero_veiculo * 80) % 255,
      (@numero_veiculo * 120) % 255
    )

    puts "#{cor}>>>>>>>>>> VEÍCULO #{@numero_veiculo} (#{self.class}) <<<<<<<<<<\n#{CoresHexadecimaisTerminal::RESET}"
    puts "Marca: #{@marca}"
    puts "Modelo: #{@modelo}"
    puts "Preço: R$#{@preco}"
    puts "Quilometragem: #{@km} kmh"
    puts "Ano de lançamento: #{@ano_lancamento}"
    puts "Velocidade: #{@velocidade}"
  end
end

class Carro < VeiculoAutoMovel
  def initialize(marca, modelo, preco, km, ano_lancamento, velocidade,
                 quantidade_portas, quantidade_marchas, quantidade_passageiros,
                 passageiros_atuais, tipo_cambio, tipo_combustivel,
                 capacidade_porta_malas, piloto_automatico)
    super(marca, modelo, preco, km, ano_lancamento, velocidade)

    @quantidade_portas = quantidade_portas
    @quantidade_marchas = quantidade_marchas
    @quantidade_passageiros = quantidade_passageiros
    @passageiros_atuais = passageiros_atuais
    @tipo_cambio = tipo_cambio
    @tipo_combustivel = tipo_combustivel
    @capacidade_porta_malas = capacidade_porta_malas
    @piloto_automatico = piloto_automatico

    @passageiros_atuais = 0
  end

  def set_quantidade_portas(valor) = (@quantidade_portas = valor if valor > 0)
  def set_quantidade_marchas(valor) = (@quantidade_marchas = valor if valor > 0)
  def set_quantidade_passageiros(valor) = (@quantidade_passageiros = valor if valor > 0)
  def set_tipo_combustivel(valor) = (@tipo_combustivel = valor)
  def set_tipo_cambio(valor) = (@tipo_cambio = valor)
  def set_capacidade_porta_malas(valor) = (@capacidade_porta_malas = valor if valor > 0)
  def set_piloto_automatico(valor) = (@piloto_automatico = valor)

  def entrar_passageiro
    if @passageiros_atuais < @quantidade_passageiros
      @passageiros_atuais += 1
      puts "Passageiro entrou! Quantidade de passageiros: #{@passageiros_atuais}"
    else
      puts "Carro lotado!"
    end
  end

  def sair_passageiro
    if @passageiros_atuais > 0
      @passageiros_atuais -= 1
      puts "Passageiro saiu! Quantidade de passageiros: #{@passageiros_atuais}"
    else
      puts "Não há passageiros no carro!"
    end
  end

  def ativar_piloto_automatico
    unless @piloto_automatico
      puts "Este carro não possui piloto automático."
      return
    end

    if velocidade < 40
      puts "Velocidade mínima de 40km/h."
      return
    end

    puts "Piloto automático ativado."
  end

  def mostrar_dados
    super
    puts "Quantidade de portas: #{@quantidade_portas}"
    puts "Tipo de câmbio: #{@tipo_cambio}"
    puts "Quantidade de marchas: #{@quantidade_marchas}"
    puts "Quantidade de passageiros permitido: #{@quantidade_passageiros}"
    puts "Tipo de combustível: #{@tipo_combustivel}"
    puts "Capacidade do porta malas: #{@capacidade_porta_malas} L"
    puts "Tem piloto automático: #{@piloto_automatico}"
  end
end

class Onibus < VeiculoAutoMovel
  def initialize(marca, modelo, preco, km, ano_lancamento, velocidade,
                 quantidade_portas, quantidade_assentos, capacidade_passageiros,
                 quantidade_passageiros_atuais, quantidade_marchas,
                 porta_aberta, ar_condicionado, cobrador, tv)
    super(marca, modelo, preco, km, ano_lancamento, velocidade)

    @quantidade_portas = quantidade_portas
    @quantidade_assentos = quantidade_assentos
    @capacidade_passageiros = capacidade_passageiros
    @quantidade_passageiros_atuais = quantidade_passageiros_atuais
    @quantidade_marchas = quantidade_marchas
    @porta_aberta = porta_aberta
    @ar_condicionado = ar_condicionado
    @cobrador = cobrador
    @tv = tv

    # Igual ao seu Java: força estado inicial
    @quantidade_passageiros_atuais = 0
    @porta_aberta = false
  end

  def set_quantidade_portas(valor) = (@quantidade_portas = valor if valor > 0)
  def set_quantidade_assentos(valor) = (@quantidade_assentos = valor if valor > 0)
  def set_capacidade_passageiros(valor) = (@capacidade_passageiros = valor if valor > 0)
  def set_quantidade_marchas(valor) = (@quantidade_marchas = valor if valor > 0)

  def abrir_porta
    if velocidade == 0
      @porta_aberta = true
      puts "Portas abertas!"
    else
      puts "Ônibus em movimento, não pode abrir as portas!"
    end
  end

  def fechar_porta
    @porta_aberta = false
    puts "Portas fechadas!"
  end

  def embarcar_passageiro
    if @quantidade_passageiros_atuais < @capacidade_passageiros
      @quantidade_passageiros_atuais += 1
    else
      puts "Ônibus lotado!"
    end
  end

  def descer_passageiro
    if velocidade > 0
      puts "O ônibus precisa estar parado para descer passageiros."
      return
    end

    if @quantidade_passageiros_atuais > 0
      @quantidade_passageiros_atuais -= 1
      puts "Passageiro desceu! Quantidade de passageiros: #{@quantidade_passageiros_atuais}"
    else
      puts "Não há passageiros para descer."
    end
  end

  def acelerar(incremento)
    if @porta_aberta
      puts "Portas abertas! Feche as portas para poder acelerar!"
      return
    end
    super
  end

  def mostrar_dados
    super
    puts "Quantidade de portas: #{@quantidade_portas}"
    puts "Quantidade de assentos: #{@quantidade_assentos}"
    puts "Capacidade de passageiros: #{@capacidade_passageiros}"
    puts "Passageiros atuais: #{@quantidade_passageiros_atuais}"
    puts "Ar-condicionado: #{@ar_condicionado ? 'Sim' : 'Não'}"
    puts "Cobrador: #{@cobrador ? 'Sim' : 'Não'}"
    puts "TV: #{@tv ? 'Sim' : 'Não'}"
  end
end

class Moto < VeiculoAutoMovel
  def initialize(marca, modelo, preco, km, ano_lancamento, velocidade,
                 cilindradas, quantidade_marchas, capacidade_tanque, tipo_moto)
    super(marca, modelo, preco, km, ano_lancamento, velocidade)
    @cilindradas = cilindradas
    @quantidade_marchas = quantidade_marchas
    @capacidade_tanque = capacidade_tanque
    @tipo_moto = tipo_moto
  end

  def set_cilindradas(valor) = (@cilindradas = valor if valor > 0)
  def set_quantidade_marchas(valor) = (@quantidade_marchas = valor if valor > 0)
  def set_capacidade_tanque(valor) = (@capacidade_tanque = valor if valor > 0)
  def set_tipo_moto(valor) = (@tipo_moto = valor)

  def acelerar(incremento)
    if incremento > 30
      puts "Aceleração brusca para moto!"
      return
    end
    super
  end

  def mostrar_dados
    super
    puts "Cilindradas: #{@cilindradas} cc"
    puts "Marchas: #{@quantidade_marchas}"
    puts "Capacidade do tanque: #{@capacidade_tanque} L"
    puts "Tipo de moto: #{@tipo_moto}"
  end
end
    
class Aviao < VeiculoAutoMovel
  def initialize(marca, modelo, preco, km, ano_lancamento, velocidade,
                 capacidade_passageiros, quantidade_passageiros_atuais, quantidade_tripulantes,
                 altitude, comida, trem_pouso_abaixado, piloto_automatico,
                 wifi, classe_executiva, tipo_aviao)
    super(marca, modelo, preco, km, ano_lancamento, velocidade)

    @capacidade_passageiros = capacidade_passageiros
    @quantidade_passageiros_atuais = 0
    @quantidade_tripulantes = quantidade_tripulantes

    @altitude = 0
    @comida = false
    @trem_pouso_abaixado = true

    @piloto_automatico = piloto_automatico
    @wifi = wifi
    @classe_executiva = classe_executiva
    @tipo_aviao = tipo_aviao
  end

  def set_capacidade_passageiros(valor) = (@capacidade_passageiros = valor if valor > 0)

  def embarcar_passageiros
    if @quantidade_passageiros_atuais < @capacidade_passageiros
      @quantidade_passageiros_atuais += 1
    else
      puts "Avião lotado!"
    end
  end

  def set_quantidade_tripulantes(valor) = (@quantidade_tripulantes = valor if valor > 0)
  def set_tipo_aviao(valor) = (@tipo_aviao = valor)

  def decolar
    if velocidade >= 250
      @altitude = 1000
      @trem_pouso_abaixado = false
      puts "Avião decolou!"
    else
      puts "Velocidade insuficiente para iniciar a decolagem!"
    end
  end

  def subir_aviao(metros)
    @altitude += metros if @altitude > 0
  end

  def set_servir_comida
    if @altitude >= 10_000
      @comida = true
      puts "Serviço de bordo iniciado!"
    else
      puts "Altitude insuficiente para iniciar o serviço de bordo!"
    end
  end

  def desligar_trem_pouso
    if @altitude >= 100
      @trem_pouso_abaixado = false
      puts "Avião decolando! Trem de pouso desligado!"
    else
      puts "Avião em solo! Trem de pouso ligado!"
    end
  end

  def set_piloto_automatico(_piloto_automatico)
    if @altitude > 10_000
      @piloto_automatico = true
      puts "Piloto automático ligado!"
    else
      puts "Altitude insuficiente para ligar o piloto automático!"
    end
  end

  def desligar_piloto_automatico
    @piloto_automatico = false
    puts "Piloto automático desligado!"
  end

  def conectar_internet
    if @altitude >= 5000
      @wifi = true
      puts "Wi-fi ligado!"
    else
      puts "Wi-fi não conectado! Só será ativado durante o voo!"
    end
  end

  def desligar_wifi
    @wifi = false
    puts "Wi-fi desligado!"
  end

  def configurar_classe_executiva(possui_classe_executiva)
    @classe_executiva = possui_classe_executiva
    puts(@classe_executiva ? "Avião com classe executiva." : "Avião sem classe executiva.")
  end

  def mostrar_dados
    super
    puts "Tipo de avião: #{@tipo_aviao}"
    puts "Capacidade de passageiros: #{@capacidade_passageiros}"
    puts "Passageiros atuais: #{@quantidade_passageiros_atuais}"
    puts "Quantidade de tripulantes: #{@quantidade_tripulantes}"
    puts "Altitude atual: #{@altitude} m"
    puts "Trem de pouso abaixado: #{@trem_pouso_abaixado ? 'Sim' : 'Não'}"
    puts "Piloto automático: #{@piloto_automatico ? 'Ligado' : 'Desligado'}"
    puts "Serviço de bordo: #{@comida ? 'Ativo' : 'Inativo'}"
    puts "Wi-Fi: #{@wifi ? 'Ligado' : 'Desligado'}"
    puts "Classe executiva: #{@classe_executiva ? 'Sim' : 'Não'}"
  end
end

class Trem < VeiculoAutoMovel
  def initialize(marca, modelo, preco, km, ano_lancamento, velocidade,
                 quantidade_vagoes, capacidade_por_vagao, quantidade_passageiros, quantidade_passageiros_atuais,
                 portas_abertas, na_estacao)
    super(marca, modelo, preco, km, ano_lancamento, velocidade)

    @quantidade_vagoes = quantidade_vagoes
    @capacidade_por_vagao = capacidade_por_vagao
    @quantidade_passageiros = quantidade_passageiros
    @quantidade_passageiros_atuais = 0

    @portas_abertas = true
    @na_estacao = true
  end

  def set_quantidade_vagoes(valor) = (@quantidade_vagoes = valor if valor > 0)
  def set_quantidade_passageiros(valor) = (@quantidade_passageiros = valor if valor > 0)

  def embarcar_passageiros
    if @quantidade_passageiros_atuais < @quantidade_passageiros
      @quantidade_passageiros_atuais += 1
      puts "Passageiros embarcando!"
    else
      puts "Trem lotado!"
    end
  end

  def desembarcar_passageiros
    if velocidade > 0
      puts "O trem está em movimento!"
      return
    end

    if @quantidade_passageiros_atuais > 0
      @quantidade_passageiros_atuais -= 1
      puts "Passageiro desceu! Quantidade de passageiros: #{@quantidade_passageiros_atuais}"
    else
      puts "Não há passageiros para descer."
    end
  end

  def abrir_portas
    if velocidade == 0 && @na_estacao
      @portas_abertas = true
      puts "Portas abertas."
    else
      puts "O trem precisa estar parado na estação."
    end
  end

  def chegar_estacao
    if velocidade == 0
      @na_estacao = true
      puts "Trem chegou à estação!"
    end
  end

  def mostrar_dados
    super
    puts "Quantidade de vagões: #{@quantidade_vagoes}"
    puts "Passageiros atuais: #{@quantidade_passageiros_atuais}"
    puts "Na estação: #{@na_estacao}"
    puts "Portas abertas: #{@portas_abertas}"
  end
end

carro1 = Carro.new("Honda", "Civic Hybrid 2025", 265_900, 0, 2025, 180,
                   4, 5, 3, 3, "Automático/Elétrico", "Aditivada", 495, false)

carro2 = Carro.new("Porsche", "Panamera Turbo S E-Hybrid", 991_755, 259_456, 2022, 315,
                   4, 8, 5, 2, "Automático", "Comum", 425, true)

carro3 = Carro.new("Renault", "Kwid Desgrama Outsider", 47_520, 20_547, 2019, 2,
                   4, 5, 5, 8, "Manual", "Comum", 290, false)

onibus1 = Onibus.new("Mercedes-Benz", "OF 1519", 165_000, 0, 2014, 80,
                     3, 32, 85, 70, 5, true, false, true, false)

onibus2 = Onibus.new("BYD", "BYD D9W", 2_800_000, 0, 2025, 70,
                     2, 40, 100, 140, 6, false, true, false, true)

onibus3 = Onibus.new("Volkswagen", "Volksbus 17.230 OD", 300_000, 80_000, 2016, 95,
                     3, 45, 120, 10, 5, true, false, true, false)

moto1 = Moto.new("Kawasaki", "Ninja ZX-10R", 115_000.00, 0.0, 2024, 299,
                 5, 8, 450, "Esportiva")

moto2 = Moto.new("Yamaha", "MT-07", 47_500.00, 0.0, 2024, 230,
                 2, 6, 250, "Urbano")

moto3 = Moto.new("BMW", "R 1250 GS", 125_000.00, 5500.0, 2024, 200,
                 4, 6, 320, "Trabalho")

aviao1 = Aviao.new("Embraer", "Phenom 300", 50_000_000.0, 500.0, 2023, 839,
                   10, 8, 2, 9500.0, false, false, true, true, false, "Jato")

aviao2 = Aviao.new("Cessna", "172 Skyhawk", 2_500_000.0, 1500.0, 2022, 226,
                   3, 2, 1, 15_000.0, false, true, false, false, false, "Monomotor")

aviao3 = Aviao.new("LATAM Airlines Group", "A320", 600_000_000.0, 2500.0, 2021, 876,
                   220, 210, 2, 0, true, true, false, true, false, "Passageiro bimotor de fuselagem estreita")

trem1 = Trem.new("Alstom", "TGV Euroduplex", 180_000_000.0, 12_000.0, 2022, 320,
                 10, 70, 80, 80, false, false)

trem2 = Trem.new("Siemens", "Velaro", 150_000_000.0, 8500.0, 2021, 330,
                 8, 70, 80, 50, true, false)

trem3 = Trem.new("Bombardier", "Zefiro 380", 140_000_000.0, 5000.0, 2023, 380,
                 15, 90, 150, 200, false, true)

veiculos = [
  carro1, carro2, carro3,
  onibus1, onibus2, onibus3,
  moto1, moto2, moto3,
  aviao1, aviao2, aviao3,
  trem1, trem2, trem3
]

veiculos.each do |v|
  v.mostrar_dados
  puts "\n+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=\n\n"
end
