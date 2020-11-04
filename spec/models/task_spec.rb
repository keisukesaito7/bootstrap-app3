require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.build(:task)
  end

  describe 'tasks#create' do
    it '全ての値が入力されれば保存できる' do
      expect(@task).to be_valid
    end

    it 'contentが空だと保存できない' do
      @task.content = nil
      @task.valid?
      expect(@task.errors.full_messages).to include("Content can't be blank")
    end

    it 'userが紐づいていないと保存できない' do
      @task.user = nil
      @task.valid?
      expect(@task.errors.full_messages).to include("User must exist")
    end
  end
end