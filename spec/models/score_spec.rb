require 'rails_helper'

RSpec.describe Score, type: :model do
  describe 'スコアの新規登録' do
    before do
      @user = FactoryBot.create(:user)
      @book = FactoryBot.build(:book)
      @book.user_id = @user.id
      @book.save
      @score = FactoryBot.build(:score)
      @score.book_id = @book.id
    end
    context 'スコアの新規登録が出来る' do
      it '過不足なくデータが送信されている' do
        expect(@score).to be_valid
      end
    end
  end
end
