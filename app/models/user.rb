class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :scores

  validates :nickname, null: false, format: { with: /\A^([a-zA-Z0-9]{1,8})$\z/, message: "半角英数8文字以内で入力してください" }
end
