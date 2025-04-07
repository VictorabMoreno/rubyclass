require_relative '../models/usuario'

class AutenticacaoService
  def initialize(email, senha)
    @email = email
    @senha = senha
  end

  def call
    if Usuario.validar_credenciais(@email, @senha)
      puts "Login realizado com sucesso!"
      true
    else
      puts "Credenciais inválidas."
      false
    end
  end
end