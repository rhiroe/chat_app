class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room, optional: true
  validates :content, presence: true

  after_create_commit { MessageBroadcastJob.perform_later self }
end
