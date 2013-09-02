require 'spec_helper'

def response_as_json
  JSON.parse(response.body)
end

describe Api::TasksController do
  let(:valid_user_params) {
    {
        email: 'test@example.com',
        password: 'testtest',
        password_confirmation: 'testtest'
    }
  }

  def authenticate_user(user)
    allow(controller).to receive(:require_authentication).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET index' do
    describe 'authorized' do
      let(:user) { User.create(valid_user_params) }
      before :each do
        authenticate_user(user)
      end

      it 'returns status 200' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'returns tasks as JSON array' do
        user.tasks.create(description: 'task1')
        user.tasks.create(description: 'task2')
        get :index
        expect(response_as_json).to have(2).items
      end
    end

    describe 'unauthorized' do
      it 'returns status 401' do
        get :index
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'POST create' do
    describe 'authorized' do
      let(:user) { User.create(valid_user_params) }
      before :each do
        authenticate_user(user)
      end

      it 'returns status 201' do
        post :create
        expect(response.status).to eq(201)
      end

      it 'returns the newly created task in JSON' do
        post :create, description: 'My description'
        expect(response_as_json.to_json).to eq(Task.first.to_json)
      end

      it 'uses the params to create the object' do
        post :create, description: 'Test description', priority: 1, due_date: '2013-05-06', completed: true
        expect(response_as_json['description']).to eq('Test description')
        expect(response_as_json['priority']).to eq(1)
        expect(response_as_json['due_date']).to eq('2013-05-06')
        expect(response_as_json['completed']).to eq(true)
      end
    end

    describe 'unauthorized' do
      it 'returns status 401' do
        post :create
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'PUT update' do
    describe 'authorized' do
      let(:user) { User.create(valid_user_params) }
      let(:task) { user.tasks.create }
      before :each do
        authenticate_user(user)
      end

      it 'returns status 200' do
        put :update, { id: task.id, description: 'Test description2', priority: 2, due_date: '2011-01-01', completed: false}
        expect(response_as_json['description']).to eq('Test description2')
        expect(response_as_json['priority']).to eq(2)
        expect(response_as_json['due_date']).to eq('2011-01-01')
        expect(response_as_json['completed']).to eq(false)
      end

      it 'returns status 200' do
        put :update, { id: task.id }
        expect(response.status).to eq(200)
      end
    end

    describe 'unauthorized' do
      it 'returns status 401' do
        put :update, {id: 0 }
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'DELETE destroy' do
    describe 'authorized' do
      let(:user) { User.create(valid_user_params) }
      let(:task) { user.tasks.create }
      before :each do
        authenticate_user(user)
      end

      it 'returns status 200' do
        delete :destroy, { id: task.id }
        expect(response.status).to eq(200)
      end

      it 'deletes the task' do
        delete :destroy, { id: task.id }
        expect(Task).to have(0).items
      end
    end

    describe 'unauthorized' do
      it 'returns status 401' do
        delete :destroy, {id: 0 }
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'POST archive' do
    describe 'authorized' do
      let(:user) { User.create(valid_user_params) }
      let(:task) { user.tasks.create }
      before :each do
        authenticate_user(user)
      end

      it 'returns status 200' do
        post :archive
        expect(response.status).to eq(200)
      end

      it 'archives completed tasks' do
        allow(user).to receive(:archive_completed_tasks!)
        post :archive
        expect(user).to have_received(:archive_completed_tasks!)
      end
    end

    describe 'unauthorized' do
      it 'returns status 401' do
        post :archive
        expect(response.status).to eq(401)
      end
    end
  end
end
