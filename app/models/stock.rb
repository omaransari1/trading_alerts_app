class Stock < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true, uniqueness: true
end
