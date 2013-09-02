class Task < ActiveRecord::Base
  default_scope { where(archived: false) }

  belongs_to :user

end
