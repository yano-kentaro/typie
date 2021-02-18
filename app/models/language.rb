class Language < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :color

  has_many :book_languages
  has_many :books, through :book_languages

  validates :name, presence: true, unique: true
  validates :color_id, numericality: { other_than: 1 }
end
