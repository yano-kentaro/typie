require 'rails_helper'

RSpec.describe Word, type: :model do
  describe '英単語新規登録' do
    before  do
      @word = FactoryBot.build(:word)
    end
    context '英単語を新規登録出来る' do
      it '半角英字2文字以上である' do
        expect(@word).to be_valid
      end
    end
    context '英単語を新規登録できない' do
      it '英単語が未記入' do
        @word.word = ''
        @word.valid?
        expect(@word.errors.full_messages).to include('Word 半角英字2文字以上の入力が必要です')
      end
      it '英単語が半角英字１文字' do
        @word.word = 'a'
        @word.valid?
        expect(@word.errors.full_messages).to include('Word 半角英字2文字以上の入力が必要です')
      end
      it '英単語が全角文字1文字' do
        @word.word = 'あ'
        @word.valid?
        expect(@word.errors.full_messages).to include('Word 半角英字2文字以上の入力が必要です')
      end
      it '英単語が記号1文字' do
        @word.word = '@'
        @word.valid?
        expect(@word.errors.full_messages).to include('Word 半角英字2文字以上の入力が必要です')
      end
      it '英単語が全角文字を含む2文字以上' do
        @word.word = 'あa'
        @word.valid?
        expect(@word.errors.full_messages).to include('Word 半角英字2文字以上の入力が必要です')
      end
      it '英単語が記号を含む2文字以上' do
        @word.word = '@a'
        @word.valid?
        expect(@word.errors.full_messages).to include('Word 半角英字2文字以上の入力が必要です')
      end
    end
  end
end
