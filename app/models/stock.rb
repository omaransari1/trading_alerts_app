class Stock < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true, uniqueness: { scope: :user_id,
    message: "should happen once per user" }
end
