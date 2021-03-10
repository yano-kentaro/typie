require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end
    context 'ユーザー登録出来るとき' do
      it '入力事項が過不足なく記入されている' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー登録出来ないとき' do
      it 'ニックネームが未記入' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname 半角英数8文字以内で入力してください')
      end
      it 'ニックネームに全角文字が入っている' do
        @user.nickname = 'あabc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname 半角英数8文字以内で入力してください')
      end
      it 'ニックネームに記号が入っている' do
        @user.nickname = '@abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname 半角英数8文字以内で入力してください')
      end
      it 'ニックネームが8文字以上' do
        @user.nickname = '123456789'
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname 半角英数8文字以内で入力してください')
      end
      it 'ニックネームが全角8文字以上' do
        @user.nickname = 'あいうえおあいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname 半角英数8文字以内で入力してください')
      end
      it 'ニックネームが記号8文字以上' do
        @user.nickname = '@@@@@@@@@@'
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname 半角英数8文字以内で入力してください')
      end
      it 'メールアドレスが未記入' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスに@が含まれていない' do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが記入されていない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは6文字以上でない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは確認用も含めて２回記入されていない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードと確認用パスワードが一致しない' do
        @user.password = 'abc123'
        @user.password_confirmation = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
