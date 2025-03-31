require 'json'
require_relative '../services/reserva_service'
require_relative '../services/mesa_service'
require_relative '../jobs/enviar_confirmacao_job'

class API
  def call(env)
    req = Rack::Request.new(env)
    method = req.request_method
    path = req.path_info

    case
    when method == 'GET' && path == '/reservas'
      [200, json, [ReservaService.listar.to_json]]

    when method == 'POST' && path == '/reservas'
      body = JSON.parse(req.body.read)
      reserva = ReservaService.criar(body)
      EnviarConfirmacaoJob.perform_async(reserva)
      [201, json, [reserva.to_json]]

    when method == 'GET' && path.match(%r{^/reservas/\d+$})
      id = path.split("/").last
      reserva = ReservaService.buscar(id)
      return [404, json, [{ erro: "Reserva não encontrada" }.to_json]] unless reserva
      [200, json, [reserva.to_json]]

    when method == 'DELETE' && path.match(%r{^/reservas/\d+$})
      id = path.split("/").last
      reserva = ReservaService.cancelar(id)
      return [404, json, [{ erro: "Reserva não encontrada" }.to_json]] unless reserva
      [200, json, [{ mensagem: "Reserva cancelada" }.to_json]]

    when method == 'GET' && path == '/mesas'
      [200, json, [MesaService.listar.to_json]]

    when method == 'GET' && path == '/mesas/disponiveis'
      pessoas = req.params["pessoas"].to_i
      mesas = MesaService.disponiveis(pessoas)
      [200, json, [mesas.to_json]]

    else
      [404, json, [{ erro: "Rota não encontrada" }.to_json]]
    end
  end

  def json
    { 'Content-Type' => 'application/json' }
  end
end