require 'rails_helper'

RSpec.describe "Tasks#Create", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task_content = Faker::Lorem.sentence
  end

  context 'タスクを投稿できるとき' do
    it '正しい情報が入力されればタスクが投稿されトップページへ移動' do
      # トップページへアクセス
      visit root_path
      # ログイン
      sign_in(@user)
      # 「新規タスク」ボタンを押して新規タスク投稿画面へ
      find_link("新規タスク", href: new_task_path).click
      # フォームに@task_contentを入力
      fill_in "task_content", with: @task_content
      # Create Taskを押して送信
      expect{ find("input[name='commit']").click }.to change{ Task.count }.by(1)
      # root_pathに遷移したことを確認
      expect(current_path).to eq root_path
      # ページ内に@task_contentがあることを確認
      expect(page).to have_content(@task_content)
    end
  end

  context 'タスクを投稿できないとき' do
    it 'ログインしていなければタスク新規作成ページへ遷移できない' do
      # トップページへアクセス
      visit root_path
      # タスク新規作成ページへアクセス
      visit new_task_path
      # ログインしていないのでログインページへリダイレクトされる
      expect(current_path).to eq new_user_session_path
    end

    it 'ログインしてもフォームを正しく送信しないとタスクを投稿できない' do
      # トップページへアクセス
      visit root_path
      # ログイン
      sign_in(@user)
      # 「新規タスク」ボタンを押して新規タスク投稿画面へ
      find_link("新規タスク", href: new_task_path).click
      # フォームに@task_contentを入力
      fill_in "task_content", with: ""
      # Create Taskを押した時にタスクモデルのカウントが上がらないことを確認
      expect{ find("input[name='commit']").click }.to change{ Task.count }.by(0)
      # タスク新規投稿ページに戻ってくることを確認
      expect(current_path).to eq '/tasks'
    end
  end

end
