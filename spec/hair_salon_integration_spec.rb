require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

    describe('adding a new stylist', {:type => :feature}) do
      it('allows a user to add a stylist and view thier clients and stylist details') do
        visit('/stylists')
        # click_link('Add a Stylist')
        fill_in('name', :with => 'Jane Brown')
        click_button('Add Stylist')
        expect(page).to have_content('Jane Brown')
      end
    end
  describe('viewing all of the stylists', {:type => :feature}) do
    it('allows a user to see all of the stylists that have been created') do
      stylist = Stylist.new({:name => 'Jane Brown', :id => nil})
      stylist.save()
      visit('/')
      click_link('List of Stylists')
      expect(page).to have_content(stylist.name())
     end
   end

  describe('seeing details for a single stylist', {:type => :feature}) do
    it('allows a user to click a stylist to see the  details for it') do
      test_list = Stylist.new({:name => 'Jane Brown',:id => nil})
      test_list.save()
      test_task = Client.new({:name => "Joe Brown",:id=>nil, :stylist_id => test_list.id()})
      test_task.save()
      visit('/stylists')
      click_link(test_list.name())
      expect(page).to have_content(test_task.name())
    end
  end
  describe('adding clients to a stylist', {:type => :feature}) do
    it('allows a user to add a clients to a stylist') do
      test_list = Stylist.new({:name => 'Jane Brown',:id => nil})
      test_list.save()
      visit("/clients")
      fill_in("name", {:with => "Chandler Bing"})
      click_button("Add Client")
      expect(page).to have_content("Chandler Bing")
    end
  end
  describe('updating stylist information', {:type => :feature}) do
  it('allows a user to update the name of a stylist') do
    test_list = Stylist.new({:name => 'Jane Brown', :id => nil})
    test_list.save()
    visit("/stylists/#{test_list.id()}")
    fill_in("name", {:with => 'Joe Brown'})
    click_button('Update')
    expect(page).to have_content('Joe Brown')
  end
end
describe('updating client information', {:type => :feature}) do
  it('allows a user to update the name of a client') do
    test_list = Stylist.new({:name => 'Jane Brown', :id => nil})
    test_list.save()
    test_task = Client.new({:name => 'Chandler Bing', :id => nil, :stylist_id => test_list.id()})
    test_task.save()
    visit("/clients/#{test_task.id()}")
    fill_in("name", {:with => 'Joey Tribbiani'})
    click_button('Update')
    expect(page).to have_content('Joey Tribbiani')
  end
end
# describe('deleting stylist information', {:type => :feature}) do
#   it('allows a user to delete a stylist') do
#     test_list = Stylist.new({:name => 'Jane Brown', :id => nil})
#     test_list.save()
#     visit("/stylists/#{test_list.id()}")
#     find('stylist_select').find(:xpath, 'option[1]').select_option
#     click_button('Remove Stylist')
#     expect(page).to have_no_content('Jane Brown')
#   end
# end
# describe('deleting client information', {:type => :feature}) do
#   it('allows a user to delete a client') do
#
#     test_task = Client.new({:name => 'Chandler Bing', :id => nil, :stylist_id => test_list.id()})
#     test_task.save()
#     visit("/clients")
#     find('client_select').find(:xpath, 'option[1]').select_option
#     click_button('Remove Client')
#     expect(page).to have_no_content('Chandler Bing')
#   end
# end
