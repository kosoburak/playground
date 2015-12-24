class Message < ActiveRecord::Base
  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'

  validates :from, presence: true
  validates :to, presence: true
  validates :text, presence: true
  validates :send_time, presence: true
end
