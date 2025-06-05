class Session < ApplicationRecord
  belongs_to :account, class_name: 'User'
end
