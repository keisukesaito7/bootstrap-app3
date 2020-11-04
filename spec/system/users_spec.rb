require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録ができるとき' do
    it '正しい情報が入力されれば登録されトップページへ移動' do
      # トップページへ移動
      visit root_path
      # 新規登録ボタンを確認
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動
      visit new_user_registration_path
      # ユーザー情報を入力
      fill_in 'user_name', with: @user.name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # クリックしてモーダルを表示
      find("button[data-target='#exampleModal']").click
      # モーダル上の「アカウント登録」ボタンを押してユーザーを登録
      expect{ find("input[name='commit']").click }.to change{ User.count }.by(1)
      # 登録後はtasks_pathへ遷移
      expect(current_path).to eq tasks_path
      # ヘッダーに「ログアウト」ボタンを確認
      expect(page).to have_content("ログアウト")
      # ヘッダーから「ログイン」「新規登録」がなくなったことを確認
      expect(page).to have_no_content("ログイン")
      expect(page).to have_no_content("新規登録")
    end
  end
end
