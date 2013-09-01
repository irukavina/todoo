class Api::TasksController < Api::BaseController
  before_filter :require_authentication

  def index
    render json: [
        { id: '1', description: 'this' },
        { id: '2', description: 'that' }
    ]
  end
end
