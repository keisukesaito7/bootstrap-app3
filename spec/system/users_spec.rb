require 'rails_helper'

RSpec.describe "Users#Resistration", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
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
      expect(current_path).to eq root_path
      # ヘッダーに「ログアウト」ボタンを確認
      expect(page).to have_content("ログアウト")
      # ヘッダーから「ログイン」「新規登録」がなくなったことを確認
      expect(page).to have_no_content("ログイン")
      expect(page).to have_no_content("新規登録")
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録できずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in "user_name", with: ""
      fill_in "user_email", with: ""
      fill_in "user_password", with: ""
      fill_in "user_password_confirmation", with: ""
      # クリックしてモーダルを表示
      find("button[data-target='#exampleModal']").click
      # アカウント登録を押してもユーザーモデルのカウントは上がらないことを確認する
      expect{ find("input[name='commit']").click }.to change{ User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe "Users#Session", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it 'ログインページで正しく入力すればログインしトップページへ移動' do
      # トップページへ移動
      visit root_path
      # ログインボタンを確認
      expect(page).to have_content("ログイン")
      # ログインページへ遷移
      visit new_user_session_path
      # フォームに値を入力
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      # モーダルを表示
      find("button[data-target='#exampleModal']").click
      # ログインボタンをクリック
      find("input[name='commit']").click
      # ページ遷移を確認
      expect(current_path).to eq root_path
      # ログアウトボタンの確認
      expect(page).to have_content("ログアウト")
      # 新規登録、ログインボタンがないのを確認
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end

  context 'ログインができないとき' do
    it 'ログインページで正しく入力されなければログインページへ戻ってくる' do
      # トップページへ移動
      visit root_path
      # ログインボタンを確認
      expect(page).to have_content("ログイン")
      # ログインページへ遷移
      visit new_user_session_path
      # フォームに値を入力
      fill_in "user_email", with: ""
      fill_in "user_password", with: ""
      # モーダルを表示
      find("button[data-target='#exampleModal']").click
      # ログインボタンをクリック
      find("input[name='commit']").click
      # ページ遷移を確認
      expect(current_path).to eq '/users/sign_in'
    end
  end

end
