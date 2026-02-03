require 'tk'

# Configuração da Janela Principal
root = TkRoot.new do
  title "Calculadora Científica Ruby"
  geometry "400x480"
  resizable 0, 0
end

# Variável que armazena o texto do display
display_var = TkVariable.new

# Função para adicionar caracteres ao display
def add_char(display_var, char)
  current = display_var.value
  display_var.value = current.to_s + char
end

# Função para limpar o display
def clear_display(display_var)
  display_var.value = ""
end

# Função para apagar o último caractere
def backspace(display_var)
  current = display_var.value
  display_var.value = current.to_s.chop
end

# Função principal de cálculo
def calculate(display_var)
  begin
    expression = display_var.value
    
    # Substituições para tornar a string compatível com a classe Math do Ruby
    # Ex: 'sin(' vira 'Math.sin('
    expression = expression.gsub('sin', 'Math.sin')
    expression = expression.gsub('cos', 'Math.cos')
    expression = expression.gsub('tan', 'Math.tan')
    expression = expression.gsub('log', 'Math.log10')
    expression = expression.gsub('ln', 'Math.log')
    expression = expression.gsub('sqrt', 'Math.sqrt')
    expression = expression.gsub('PI', 'Math::PI')
    expression = expression.gsub('^', '**') # Ruby usa ** para potência

    # O método eval executa a string como código Ruby
    result = eval(expression)
    
    display_var.value = result.to_s
  rescue StandardError
    display_var.value = "Erro"
  end
end

# --- Interface Visual ---

# Campo de Texto (Display)
entry = TkEntry.new(root) do
  textvariable display_var
  font "Arial 20 bold"
  justify 'right'
  pack('side' => 'top', 'fill' => 'x', 'padx' => 10, 'pady' => 10)
end

# Frame para os botões
button_frame = TkFrame.new(root)
button_frame.pack('side' => 'top', 'fill' => 'both', 'expand' => true)

# Definição dos Botões (Layout de Grid)
# Cada sub-array é uma linha da calculadora
buttons = [
  ['C', 'DEL', '(', ')', '/'],
  ['sin', 'cos', 'tan', 'sqrt', '*'],
  ['7', '8', '9', '^', '-'],
  ['4', '5', '6', 'log', '+'],
  ['1', '2', '3', 'ln', 'PI'],
  ['0', '.', '=', '', ''] # Espaços vazios para layout
]

# Loop para criar os botões na tela
buttons.each_with_index do |row, r_index|
  row.each_with_index do |btn_text, c_index|
    next if btn_text.empty? # Pula botões vazios

    # Define a ação baseada no texto do botão
    cmd = proc do
      case btn_text
      when '='
        calculate(display_var)
      when 'C'
        clear_display(display_var)
      when 'DEL'
        backspace(display_var)
      when 'sin', 'cos', 'tan', 'sqrt', 'log', 'ln'
        add_char(display_var, "#{btn_text}(")
      else
        add_char(display_var, btn_text)
      end
    end

    # Se for o botão de Igual, faz ele ser maior ou com cor diferente
    bg_color = (btn_text == '=') ? '#4CAF50' : '#f0f0f0'
    fg_color = (btn_text == '=') ? 'white' : 'black'

    # Criação do botão
    TkButton.new(button_frame) do
      text btn_text
      font "Arial 12 bold"
      background bg_color
      foreground fg_color
      command cmd
      # Posicionamento no Grid
      grid('row' => r_index, 'column' => c_index, 'sticky' => 'nsew', 'padx' => 2, 'pady' => 2)
    end
  end
end

# Configuração para os botões expandirem e preencherem a janela
(0..5).each { |i| TkGrid.rowconfigure(button_frame, i, 'weight' => 1) }
(0..4).each { |i| TkGrid.columnconfigure(button_frame, i, 'weight' => 1) }

# Iniciar o loop da interface gráfica
Tk.mainloop
