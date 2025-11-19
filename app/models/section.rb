class Section < ApplicationRecord
  has_many :chats

  validates :content, presence: :true
  validates :system_prompt, presence: true
  validates :name, presence: true
end
