require 'spec_helper'

describe Task do
  describe 'default scope' do
    let!(:user) { User.create(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest') }
    let!(:unarchived) { user.tasks.create }
    let!(:archived) { user.tasks.create(archived: true) }

    before :each do
      user.reload
    end

    it 'doesn\'t list archived tasks' do
      expect(Task.all).to eq([unarchived])
    end

    it 'doesn\'t list archived tasks for that user' do
      expect(user.tasks).to eq([unarchived])
    end
  end
end
