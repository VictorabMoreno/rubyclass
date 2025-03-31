require_relative '../banco_fake'

class MesaService
  def self.listar
    BancoFake.listar_mesas
  end

  def self.disponiveis(quantidade)
    BancoFake.mesas_disponiveis(quantidade)
  end
end