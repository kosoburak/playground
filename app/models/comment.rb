class Comment < ActiveRecord::Base
  resourcify

  belongs_to :project
  belongs_to :author, class_name: 'User'
  has_many :karmas, as: :karmable

  validates :author, presence: true
  validates :project, presence: true
  validates :text, presence: true

  def has_karma?(user)
    Karma.find_by(author: user, karmable: self)
  end
end
