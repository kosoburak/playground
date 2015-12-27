class Evaluation < ActiveRecord::Base
  resourcify
  
  belongs_to :project
  belongs_to :user
  belongs_to :author, class_name: 'User'

  validates :project, presence: true
  validates :user, presence: true
  validates :author, presence: true
  validates :text, presence: true
end
