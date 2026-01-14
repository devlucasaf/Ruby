def line
  puts "+=+=" * 69
end

puts "Digite a largura do seu terreno: "
largura = gets.chomp.to_i

puts "Digite o comprimento do seu terreno: "
comprimento = gets.chomp.to_i

investimento = 225 + 500 + 1200 + 2824

area = largura * comprimento
covas = area * 4
pes = covas * 3
espigas = pes * 3
venda = espigas * 0.83

lucro = venda - investimento
gasto_mes = lucro / 12

line
puts "\nA área total do terreno é: #{area}\n"
line
puts "\nO total a ser investido: R$ #{investimento}\n"
line
puts "\nO total de covas no terreno por m²: #{covas}\n"
line
puts "\nA quantidade de pes por cova serão de: #{pes}\n"
line
puts "\nO total de espigas a serem colhidas será de: #{espigas}\n"
line
puts "\nO total adquirido com a venda das espigas será de: R$ #{'%.2f' % venda}\n"
line
puts "\nO lucro com a venda das espigas será de: R$ #{'%.2f' % lucro}\n"
line
puts "\nPoderá ser gastado por mês até acabar o dinheiro: R$ #{'%.2f' % gasto_mes}\n"
line
