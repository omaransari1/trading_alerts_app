class Stock < ApplicationRecord
  belongs_to :user

  validates :symbol, presence: true, uniqueness: { scope: :user_id,
    message: "Stock already listed in your watchlist!" }
end
