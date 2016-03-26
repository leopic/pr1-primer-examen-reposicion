require 'sinatra'
require 'json'
require 'date'

before do
  response.headers["Allow"] = "HEAD,GET,PUT,DELETE,OPTIONS"
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
end

def seeder
  transacciones = []
  fecha_inicial = Date.new(2015, 3, 26)

  (1..15).each do |i|
    transacciones.push(
        {
            :id => i,
            :fecha => fecha_inicial.prev_day(i).strftime("%d/%m/%Y"),
            :monto => i.odd? ? (i * -5) : (i * 10),
            :tipo => i.odd? ? "Debito" : "Credito",
            :descripcion => i.odd? ? "Entrada de dinero." : "Salida de dinero."
        }
    )
  end

  transacciones
end

get '/cuenta' do
  content_type :json
  cuenta = {
      :nombre_dueno => "Leonardo Picado Ortega",
      :tipo_cuenta => "Ahorros",
      :moneda => "Dolares",
      :transacciones => seeder
  }
  cuenta.to_json
end

get '/transaccion/id/:id' do
  content_type :json
  movimiento = seeder.select { |mov|
    mov[:id] == Integer(params['id'])
  }
  movimiento.to_json
end
