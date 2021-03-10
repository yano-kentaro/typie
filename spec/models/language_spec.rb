require 'rails_helper'

RSpec.describe Language, type: :model do
  describe '言語の新規登録' do
    before do
      @language = FactoryBot.build(:language)
    end
    context '言語を新規登録出来る' do
      it '言語が半角英数("_", "-"を含む)12文字以内で入力されている' do
        expect(@language).to be_valid
      end
    end
    context '言語を新規登録出来ない' do
      it '言語が未記入' do
        @language.name = ''
        @language.valid?
        expect(@language.errors.full_messages).to include('Name 半角英数12文字以内の入力が必要です')
      end
      it '言語が半角英数13文字以上入力されている' do
        @language.name = '1234567890123'
        @language.valid?
        expect(@language.errors.full_messages).to include('Name 半角英数12文字以内の入力が必要です')
      end
      it '言語が全角含む13文字以上入力されている' do
        @language.name = '123456789012あ'
        @language.valid?
        expect(@language.errors.full_messages).to include('Name 半角英数12文字以内の入力が必要です')
      end
      it '言語に全角文字が入力されている' do
        @language.name = 'あtest'
        @language.valid?
        expect(@language.errors.full_messages).to include('Name 半角英数12文字以内の入力が必要です')
      end
      it '言語に使用不可の記号が使用されている' do
        @language.name = '@test'
        @language.valid?
        expect(@language.errors.full_messages).to include('Name 半角英数12文字以内の入力が必要です')
      end
    end
  end
end
