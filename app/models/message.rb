class Message < ApplicationRecord
  validates :sender_name, presence: true
  validates :content, presence: true
end
