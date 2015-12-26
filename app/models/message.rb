
class Message < ActiveRecord::Base
  resourcify

  attr_accessor :to_name

  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'
  belongs_to :user

  validates :from, presence: true
  validates :to, presence: true
  validates :text, presence: true
  validates :send_time, presence: true
  validates :to_name, user_exist: true

  def to_name=(name)
    self.to = User.find_by name: name
    @to_name = name
  end
end
