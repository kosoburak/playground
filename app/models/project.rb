class Project < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :participants, class_name: 'User'
  has_many :comments
  has_many :positions
  has_many :karmas, as: :karmable

  validates :author, presence: true
  validates :name, presence: true
end
