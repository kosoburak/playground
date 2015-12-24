class Position < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :skils

  validates :project, presence: true

  acts_as_taggable_on :skills
end
