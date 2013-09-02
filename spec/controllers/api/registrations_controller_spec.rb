require 'spec_helper'

def response_as_json
  JSON.parse(response.body)
end

describe Api::RegistrationsController do
  describe 'POST create' do
    describe 'valid params' do
      let(:valid_params) {
        {
            email: 'test@example.com',
            password: 'testtest',
            password_confirmation: 'testtest'
        }
      }

      before :each do
        expect(User).to have(0).items
        post :create, valid_params
      end

      let(:user) { User.first }

      it 'creates a user' do
        expect(User).to have(1).item
      end

      it 'responds with status 201' do
        expect(response.status).to eq(201)
      end

      it 'responds with the user\'s authentication token' do
        expect(response_as_json['auth_token']).to eq(user.auth_token)
      end

      it 'responds with the user\'s email' do
        expect(response_as_json['email']).to eq(user.email)
      end
    end

    describe 'email taken' do
      let(:valid_params) {
        {
            email: 'test@example.com',
            password: 'testtest',
            password_confirmation: 'testtest'
        }
      }

      before :each do
        User.create(valid_params)
        expect(User).to have(1).item
        post :create, valid_params
      end

      it 'doesn\'t save the user' do
        expect(User).to have(1).item
      end

      it 'responds with 422' do
        expect(response.status).to eq(422)
      end

    end

    describe 'invalid params' do
      describe 'email' do
        let(:invalid_email) {
          {
              email: 'testexample.com',
              password: 'testtest',
              password_confirmation: 'testtest'
          }
        }

        before :each do
          post :create, invalid_email
        end

        it 'should not create a user' do
          expect(User).to have(0).items
        end

        it 'responds with 422' do
          expect(response.status).to eq(422)
        end
      end

      describe 'password mismatch' do
        let(:invalid_passwords) {
          {
              email: 'test@example.com',
              password: 'testtest1',
              password_confirmation: 'testtest2'
          }
        }

        before :each do
          post :create, invalid_passwords
        end

        it 'should not create a user' do
          expect(User).to have(0).items
        end

        it 'responds with 422' do
          expect(response.status).to eq(422)
        end
      end
    end
  end
end
