require("spec_helper")

describe(Stylist) do


  describe(".all") do
    it("starts off with no stylists") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a stylist by his/her ID number") do
      test_stylist = Stylist.new({:name => "Jane Brown", :id => nil})
      test_stylist.save()
      test_stylist2 = Stylist.new({:name => "Joe Brown", :id => nil})
      test_stylist2.save()
      expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
    end
  end

  describe("#==") do
    it("is the same stylist if it has the same name and id") do
      stylist = Stylist.new({:name => "Jane Brown", :id => nil})
      stylist2 = Stylist.new({:name => "Jane Brown", :id => nil})
      expect(stylist).to(eq(stylist2))
    end
  end
  # describe('#clients') do
  #   it('returns an array of clients for a particular stylist') do
  #     stylist = Stylist.new({:name => 'Jane_Brown', :id => nil})
  #     stylist.save()
  #     client1 = Client.new({:name => 'Chandler Bing', :id => nil, :list_id => stylist.id()})
  #     client1.save()
  #     client2 = Client.new({:name => 'Joey Tribbiani', :id => nil, :list_id => stylist.id()})
  #     client2.save()
  #     expect(stylist.clients()).to(eq([Chandler Bing, Joey Tribbiani]))
  #   end
  # end


  describe("#update") do
    it("lets you update stylists in the database") do
      stylist = Stylist.new({:name => "Jane Brown", :id => nil})
      stylist.save()
      stylist.update({:name => "Joe Brown"})
      expect(stylist.name()).to(eq("Joe Brown"))
    end
  end

  describe("#delete") do
    it("lets you delete a stylist from the database") do
      stylist = Stylist.new({:name => "Jane Brown", :id => nil})
      stylist.save()
      stylist2 = Stylist.new({:name => "Joe Brown", :id => nil})
      stylist2.save()
      stylist.delete()
      expect(Stylist.all()).to(eq([stylist2]))
    end
  end
end
