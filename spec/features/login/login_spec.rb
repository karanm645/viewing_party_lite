require 'rails_helper'

RSpec.describe 'Login Form' do 
  before :each do 
    @user = User.create!(name: "Joe", email: "xyz@gmail.com", password: "abcdef", password_confirmation: "abcdef")
    visit '/'
  end 
  describe 'when the user logs in' do 
    it 'clicks on a login link' do 
      expect(current_path).to eq("/")
      expect(page).to have_link("go to login")
      
      click_link "go to login"
      expect(current_path).to eq("/login")
    end 

    it 'fills out email and password' do 
      visit "/login"
      fill_in :name, with: "Joe"
      fill_in :email, with: "xyz@gmail.com"
      fill_in :password, with: "abcdef"
      fill_in :password_confirmation, with: "abcdef"

      click_button "login"
      expect(current_path).to eq(user_path(@user))
    end 

    it 'sad path' do 
      visit "/login"
      fill_in :name, with: "Joe"
      fill_in :email, with: "xyz@gmail.com"
      fill_in :password, with: ""
      fill_in :password_confirmation, with: "abcdef"

      click_button "login"
      save_and_open_page
      expect(current_path).to eq("/login")
    end 
  end 
end 