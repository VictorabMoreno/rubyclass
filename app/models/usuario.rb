require_relative '../../db/config'
require 'digest'

class Usuario
  def self.criar(nome, email, senha)
    senha_hash = Digest::SHA256.hexdigest(senha)
    DB.execute("INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)", [nome, email, senha_hash])
  end

  def self.buscar_por_email(email)
    resultado = DB.execute("SELECT * FROM usuarios WHERE email = ?", [email])
    resultado.first
  end

  def self.validar_credenciais(email, senha)
    senha_hash = Digest::SHA256.hexdigest(senha)
    usuario = DB.execute("SELECT * FROM usuarios WHERE email = ? AND senha = ?", [email, senha_hash])
    !usuario.empty?
  end
end