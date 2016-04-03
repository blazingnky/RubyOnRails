class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user, counter_cache: true

  default_scope {order(updated_at: :desc)}
end
