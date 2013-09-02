require 'spec_helper'

def response_as_json
  JSON.parse(response.body)
end

describe Api::SessionsController do
  let(:valid_user_params) {
    {
        email: 'test@example.com',
        password: 'testtest',
        password_confirmation: 'testtest'
    }
  }

  let(:valid_params) {
    { email: 'test@example.com',
    password: 'testtest' }
  }

  let(:invalid_params) {
    { email: 'test@example.com',
    password: 'knownknown' }
  }

  describe 'POST create' do
    describe 'valid params' do
      let!(:user) { User.create(valid_user_params) }

      before :each do
        post :create, valid_params
      end

      it 'responds with status 201' do
        expect(response.status).to eq(201)
      end

      it 'response includes auth token' do
        user.reload
        expect(response_as_json['auth_token']).to eq(user.auth_token)
      end

      it 'response includes auth token' do
        expect(response_as_json['email']).to eq(user.email)
      end
    end

    describe 'invalid params' do
      let!(:user) { User.create(valid_user_params) }

      before :each do
        post :create, invalid_params
      end

      it 'responds with status 403' do
        expect(response.status).to eq(403)
      end
    end

    describe 'non existent user' do
      it 'responds with status 403' do
        post :create
        expect(response.status).to eq(403)
      end
    end

    describe 'DELETE destroy' do
      let!(:user) { User.create!(valid_user_params) }
      let!(:old_auth_token) { user.auth_token }

      describe 'valid params and headers' do
        before :each do
          controller.should_receive(:require_authentication)
          allow(controller).to receive(:current_user).and_return(user)
          delete(:destroy)
        end

        it 'responds with status 200' do
          expect(response.status).to eq(200)
        end

        it 'auth token is changed' do
          user.reload
          expect(user.auth_token).not_to eq(old_auth_token)
        end
      end
    end
  end
end
