require("sinatra")
require("sinatra/reloader")
also_reload("lid/**/*.rb")
require("./lib/client")
require("./lib/stylist")
# require("./lib/stylists")
require('pry')

require("pg")
DB = PG.connect({:dbname=>"hair_salon"})


get('/') do
  erb(:index)
end

# Read, Create and Delete Stylists
get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

post('/stylists') do
  name = params.fetch('name')
  new_stylist = Stylist.new({:name => name, :id => nil})
  new_stylist.save()

  @stylists = Stylist.all()
  erb(:stylists)
end

delete('/stylists') do
  Stylist.find(params.fetch('stylist_select').to_i()).delete()

  @stylists = Stylist.all()
  erb(:stylists)
end

# Read, Create and Delete Clients
get('/clients') do

  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:clients)
end

post('/clients') do
  name = params.fetch('name')
  stylist = nil
  if params.has_key?('stylist_select')
    stylist_id = params.fetch('stylist_select').to_i()
    stylist = Stylist.find(stylist_id)
  end
  new_client = Client.new({:name => name, :stylist => stylist, :id => nil})
  new_client.save()
  new_client.update({:stylist => stylist})

  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:clients)
end

delete('/clients') do
  Client.find(params.fetch('client_select').to_i()).delete()

  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:clients)
end

# View and Update Stylist
get('/stylists/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i())
  @clients = Client.all()
  erb(:stylist)
end

patch('/stylists/:id') do
  name = params.fetch('name')
  @stylist = Stylist.find(params.fetch('id').to_i())

  # client_ids = params.fetch('client_ids', [])

  @stylist.update({:name => name,:id=>nil})

  @clients = Client.all()
  erb(:stylist)
end

# View and Update Client
get('/clients/:id') do
  @client = Client.find(params.fetch('id').to_i())
  @stylists = Stylist.all()
  erb(:client)
end

patch('/clients/:id') do
  name = params.fetch('name')
  @client = Client.find(params.fetch('id').to_i())

  stylist = nil
  if params.has_key?('stylist_select')
    stylist_id = params.fetch('stylist_select').to_i()
    stylist = Stylist.find(stylist_id)
  end
  @client.update({:name => name, :stylist => stylist})

  @stylists = Stylist.all()
  erb(:client)
end
 # post("/client_associate") do
 #   clients = params.fetch("venue_checkbox")
 #   @stylists=Band.find(params.fetch("id"))
 #   clients.each() do |client|
 #     checked_clients=@stylists.clients
 #     checked_clients.push(Client.find(client))
 #     @stylists.update({:clients=> checked_venues})
 #   end
 #  (erb:stylist)
 # end
 post("/Stylists/client_new") do
   name=params.fetch("name")
   stylist_id = params.fetch("stylist_id").to_i()
  @client = Client.new({:name =>name,:id=>nil, :stylist_id=>stylist_id})
  @client.save()
  @stylist = Stylist.find(params.fetch('stylist_id').to_i())
  @clients=Client.all()
   erb(:stylist)
 end
