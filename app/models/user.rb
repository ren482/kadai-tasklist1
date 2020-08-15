class User < ApplicationRecord
    has_many :tasks
    has_secure_password
    validates :name, presence: true, length: { maximum: 50 }
end
