require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'resistration#create' do
    it '全ての値が記入されれば保存できる' do
      expect(@user).to be_valid
    end

    it 'nameが空だと保存できない' do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'emailが空だと保存できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailが重複した場合は保存できない' do
      new_user = FactoryBot.build(:user)
      new_user.email = @user.email
      @user.save
      new_user.valid?
      expect(new_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'passwordが空だと保存できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下だと保存できない' do
      @user.password = "aaaaa"
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'password_confirmationが空だと保存できない' do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'password_confirmationがpasswordと一致しないと保存できない' do
      @user.password_confirmation = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end