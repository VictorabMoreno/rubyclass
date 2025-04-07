require_relative 'services/autenticacao_service'
require_relative 'models/usuario'

puts "1. Cadastrar | 2. Login"
opcao = gets.chomp.to_i

case opcao
when 1
  puts "Nome:"
  nome = gets.chomp
  puts "Email:"
  email = gets.chomp
  puts "Senha:"
  senha = gets.chomp
  Usuario.criar(nome, email, senha)
  puts "Usuário cadastrado com sucesso."

when 2
  puts "Email:"
  email = gets.chomp
  puts "Senha:"
  senha = gets.chomp
  AutenticacaoService.new(email, senha).call
end