require 'rails_helper'

RSpec.describe Party, type: :model do 
  describe 'relations' do 
    it { should belong_to :movie }
    it { should have_many :user_parties }
    it { should have_many(:users).through(:user_parties) }
  end 

  describe 'validations' do 
    it { should validate_presence_of(:day) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:duration) }
  end 
end 