require 'sinatra'
require 'json'
require 'haml'

file = File.read('repeaters.json')

$data = JSON.parse(file)

get '/' do
  haml :index
end

get '/states' do
  content_type :json
  out = []
  $data.each do |state, info|
    out.push state
  end
  out.to_json
end

get '/data/:state' do
  $data[params[:state]].to_json
  haml :pretty, :locals => {:state => params[:state], :state_data => $data[params[:state]]}
end

get '/data/:state/json' do
  content_type :json
  $data[params[:state]].to_json
end

get '/data/:state/csv' do
  content_type 'application/csv'
  attachment params[:state] + ".csv"
  csv = ''
  $data[params[:state]].each do |d|
    flat = d.flatten
    rows = []
    (1..flat.length).step(2).each do |v|
      rows.push flat[v] 
    end
    csv += rows.join(",") + "\n"
  end
  csv
end
