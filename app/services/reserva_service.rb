require_relative '../banco_fake'

class ReservaService
  def self.criar(dados)
    mesas = BancoFake.mesas_disponiveis(dados["pessoas"])
    dados["mesas"] = mesas.map { |m| m[:id] }[0..0]
    BancoFake.salvar_reserva(dados)
  end

  def self.listar
    BancoFake.todas_reservas
  end

  def self.buscar(id)
    BancoFake.encontrar_reserva(id)
  end

  def self.cancelar(id)
    BancoFake.deletar_reserva(id)
  end
end