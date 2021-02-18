class BookScore < ApplicationRecord
  belongs_to :book
  belongs_to :score
end
