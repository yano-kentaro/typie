class BookLanguage < ApplicationRecord
  belongs_to :book
  belongs_to :language
end
