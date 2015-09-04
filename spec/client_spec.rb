require("spec_helper")

describe(Client) do

  describe("#initialize") do
    it("is initialized with a name") do
      client = Client.new({:name => "Chandler Bing", :id => nil,:stylist_id => 1})
      expect(client).to(be_an_instance_of(Client))
    end

    it("can be initialized with its database ID") do
      client = Client.new({:name => "Chandler Bing", :id => 1,:stylist_id => 1})
      expect(client).to(be_an_instance_of(Client))
    end
  end

  describe(".all") do
    it("starts off with no clients") do
      expect(Client.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a client by its ID number") do
      test_client = Client.new({:name => "Chandler Bing", :id => nil,:stylist_id => 1})
      test_client.save()
      test_client2 = Client.new({:name => "Joey Tribbiani", :id => nil,:stylist_id => 1})
      test_client2.save()
      expect(Client.find(test_client2.id())).to(eq(test_client2))
    end
  end

  describe("#==") do
    it("is the same client if it has the same name and id") do
      client = Client.new({:name => "Chandler Bing", :id => nil,:stylist_id => 1})
      client2 = Client.new({:name => "Chandler Bing", :id => nil,:stylist_id => 1})
      expect(client).to(eq(client2))
    end
  end

  describe("#update") do
    it("lets you update clients in the database") do
      client = Client.new({:name => "Joey Tribbiani", :id => nil,:stylist_id => 1})
      client.save()
      client.update({:name => "Chandler Bing"})
      expect(client.name()).to(eq("Chandler Bing"))
    end
  end

  describe("#delete") do
    it("lets you delete an client from the database") do
      client = Client.new({:name => "Joey Tribbiani", :id => nil,:stylist_id => 1})
      client.save()
      client2 = Client.new({:name => "Chandler Bing", :id => nil,:stylist_id => 1})
      client2.save()
      client.delete()
      expect(Client.all()).to(eq([client2]))
    end
  end
end
