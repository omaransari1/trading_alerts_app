class Stock < ApplicationRecord
  belongs_to :user

  validates_presence_of :symbol
end
