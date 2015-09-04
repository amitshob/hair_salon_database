class Stylist
  attr_reader(:name,:id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({:name => name, :id => id}))
    end
    stylists
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM stylists WHERE id = #{id};")
    name = result.first().fetch("name")
    Stylist.new({:name => name, :id => id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_stylist|
    self.name().==(another_stylist.name()).&(self.id().==(another_stylist.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    # @stylist_id = attributes.fetch(:stylist_id)
    @id = self.id()
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
    # DB.exec("UPDATE stylists SET stylist_id = '#{@stylist_id}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end

  define_method(:clients) do
    results = DB.exec("SELECT * FROM clients WHERE stylist_id = #{@id};")
    clients = []
    results.each() do |result|
      name = result.fetch('name')
      stylist = self
      id = result.fetch('id').to_i()
      clients.push(Client.new({:name => name, :stylist => stylist, :id => id}))
    end
    clients
  end
end
