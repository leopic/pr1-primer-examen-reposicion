require 'sinatra'
require 'json'

before do
  response.headers["Allow"] = "HEAD,GET,PUT,DELETE,OPTIONS"
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
end

def seeder
  transacciones = []

  (1..50).each do |i|
    transacciones.push(
        {
            :id => i,
            :monto => (i % 2 == 0) ? (i * -5) : (i * 10),
            :descripcion => "Transaccion numero #{i}"
        }
    )
  end

  transacciones
end

get '/transaccion/todas' do
  content_type :json
  seeder.to_json
end

get '/transaccion/id/:id' do
  content_type :json
  movimiento = seeder.select { |mov|
    mov[:id] == Integer(params['id'])
  }
  movimiento.to_json
end
