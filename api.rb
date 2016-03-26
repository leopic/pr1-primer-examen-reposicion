require 'sinatra'
require 'json'

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
