require 'spec_helper'

describe User do
  let(:valid_user_params) {
    {
        email: 'test@example.com',
        password: 'testtest',
        password_confirmation: 'testtest'
    }
  }

  describe '#authentication_data_hash' do
    let!(:user) { User.create(valid_user_params) }

    before :each do
      user.reload
    end

    it 'is a hash' do
      expect(user.authentication_data_hash).to be_a(Hash)
    end
    it 'has email' do
      expect(user.authentication_data_hash[:email]).to be_present
    end
    it 'has auth_token' do
      expect(user.authentication_data_hash[:auth_token]).to be_present
    end
  end

  describe 'archive_completed_tasks!' do
    let!(:user) { User.create(valid_user_params) }
    let!(:uncompleted) { user.tasks.create }
    let!(:completed) { user.tasks.create(archived: true) }

    before :each do
      user.archive_completed_tasks!
      user.reload
    end

    it 'archives completed tasks' do
      completed.reload
      expect(completed.archived).to be_true
    end

    it 'doesn\'t touch uncompleted' do
      uncompleted.reload
      expect(uncompleted.archived).to be_false
    end
  end

end
