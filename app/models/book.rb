class Book < ApplicationRecord
  validates :title, presence: true, format: { with: /\A[\w_.]{1,12}\z/, message: '半角英数12文字以内の入力が必要です' }
  validates :color, presence: true

  belongs_to :user

  has_many :scores, dependent: :destroy
  has_many :book_languages, dependent: :destroy
  has_many :languages, through: :book_languages
  has_many :book_words, dependent: :destroy
  has_many :words, through: :book_words
end
