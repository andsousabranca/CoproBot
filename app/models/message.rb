class Message < ApplicationRecord
  belongs_to :chat

  validates :role, presence: :true
  # validates :content, presence: :true

  after_create_commit :broadcast_append_to_chat

  private

  def broadcast_append_to_chat
    broadcast_append_to chat, 
      target: "messages", 
      partial: "messages/message", 
      locals: { message: self }
  end
end
