require 'ruby2d'

# --- Configuração da Janela ---
set title: "Jogo Snake em Ruby"
set width: 1200
set height: 800
set background: 'black'

# --- Variáveis Globais ---
GRID_SIZE = 20
SPEED = 15

# Estado inicial da cobra
@snake_x = Window.width / 2
@snake_y = Window.height / 2
@vel_x = 0
@vel_y = 0
@snake_body = [[@snake_x, @snake_y]]
@snake_length = 1

# Estado do jogo
@score = 0
@game_over = false

# --- Funções Auxiliares ---

def spawn_food
  # Gera uma posição aleatória alinhada à grade (grid)
  x = rand(Window.width / GRID_SIZE) * GRID_SIZE
  y = rand(Window.height / GRID_SIZE) * GRID_SIZE
  return x, y
end

@food_x, @food_y = spawn_food

# --- Entrada do Usuário (Teclado) ---
on :key_down do |event|
  case event.key
  when 'down'
    if @vel_y == 0 # Previne volta 180 graus imediata (opcional, mas recomendado)
      @vel_x = 0
      @vel_y = GRID_SIZE
    end
  when 'up'
    if @vel_y == 0
      @vel_x = 0
      @vel_y = -GRID_SIZE
    end
  when 'right'
    if @vel_x == 0
      @vel_x = GRID_SIZE
      @vel_y = 0
    end
  when 'left'
    if @vel_x == 0
      @vel_x = -GRID_SIZE
      @vel_y = 0
    end
  end
end

# --- Loop Principal (Game Loop) ---
update do
  if @game_over
    close # Fecha a janela se perder
  end

  # Controle de FPS: O Ruby2D roda a 60 FPS por padrão.
  # Para simular a velocidade do Pygame (15), atualizamos apenas a cada X quadros.
  if Window.frames % (60 / SPEED) == 0

    # Atualiza Posição
    @snake_x += @vel_x
    @snake_y += @vel_y

    # Verifica Colisão com Paredes
    if @snake_x < 0 || @snake_x >= Window.width || @snake_y < 0 || @snake_y >= Window.height
      @game_over = true
    end

    # Corpo da Cobra
    @snake_body.push([@snake_x, @snake_y])

    if @snake_body.length > @snake_length
      @snake_body.shift # Remove o último pedaço (cauda)
    end

    # Verifica Colisão com o Próprio Corpo
    # Verificamos todos os pedaços exceto a cabeça (o último adicionado)
    @snake_body[0...-1].each do |segment|
      if segment == [@snake_x, @snake_y]
        @game_over = true
      end
    end

    # 5. Verifica se comeu a comida
    if @snake_x == @food_x && @snake_y == @food_y
      @snake_length += 1
      @score += 1
      @food_x, @food_y = spawn_food
    end
  end

  # --- Desenho (Renderização) ---
  clear # Limpa a tela a cada frame para redesenhar

  # Desenha a Comida
  Square.new(x: @food_x, y: @food_y, size: GRID_SIZE, color: 'red')

  # Desenha a Cobra
  @snake_body.each do |segment|
    Square.new(x: segment[0], y: segment[1], size: GRID_SIZE, color: 'green')
  end

  # Desenha os Pontos
  Text.new("Pontos: #{@score}", x: 1, y: 1, size: 35, color: 'red', font: 'Helvetica')
end

# Inicia a janela
show