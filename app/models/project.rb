class Project < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :participants
  has_many :comments
  has_many :positions
  has_many :karmas, as: :karmable

  validates :author, presence: true
end
