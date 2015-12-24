class Comment < ActiveRecord::Base
  belongs_to :project
  belongs_to :author
  has_many :karmas, as: :karmable

  validates :author, presence: true
  validates :project, presence: true
  validates :text, presence: true
end
