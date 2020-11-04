require 'rails_helper'

RSpec.describe "TasksController", type: :request do
  before do
    @task = FactoryBot.create(:task)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get tasks_path
      expect(response.status).to eq 302 # loginしないとtasks_pathへアクセスできない
    end
  end
end
