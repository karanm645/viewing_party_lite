class User < ApplicationRecord
  validates_presence_of :name,
                        :email,
                        :status
                        
  has_many :user_parties
  has_many :parties, through: :user_parties 
end