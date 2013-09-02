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
end
