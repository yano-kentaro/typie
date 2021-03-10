require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Bookの新規登録' do
    before do
      @user = FactoryBot.create(:user)
      @book = FactoryBot.build(:book)
      @book.user_id = @user.id
    end
    context 'Bookの新規登録が出来る' do
      it 'データが過不足なく入力されている' do
        expect(@book).to be_valid
      end
      it 'タイトルに"."が入力されていても新規登録出来る' do
        @book.title = 'test.rb'
        expect(@book).to be_valid
      end
      it 'タイトルに"_"が入力されていても新規登録出来る' do
        @book.title = 'test_test'
        expect(@book).to be_valid
      end
    end
    context 'Bookの新規登録が出来ない' do
      it 'タイトルが未記入' do
        @book.title = ''
        @book.valid?
        expect(@book.errors.full_messages).to include('Title 半角英数12文字以内の入力が必要です')
      end
      it 'タイトルが全角文字を含む12文字以内' do
        @book.title = 'あtest'
        @book.valid?
        expect(@book.errors.full_messages).to include('Title 半角英数12文字以内の入力が必要です')
      end
      it 'タイトルが使用不可の記号を含む12文字以内' do
        @book.title = '@test'
        @book.valid?
        expect(@book.errors.full_messages).to include('Title 半角英数12文字以内の入力が必要です')
      end
      it 'タイトルが13文字以上の半角英数' do
        @book.title = '1234567890abc'
        @book.valid?
        expect(@book.errors.full_messages).to include('Title 半角英数12文字以内の入力が必要です')
      end
      it 'タイトルが全角文字を含む13文字以上' do
        @book.title = '1234567890あいう'
        @book.valid?
        expect(@book.errors.full_messages).to include('Title 半角英数12文字以内の入力が必要です')
      end
      it 'タイトルが使用不可の記号を含む13文字以上' do
        @book.title = '1234567890@@@'
        @book.valid?
        expect(@book.errors.full_messages).to include('Title 半角英数12文字以内の入力が必要です')
      end
      it '色が未記入' do
        @book.color = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Color can't be blank")
      end
    end
  end
end
