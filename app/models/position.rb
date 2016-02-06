class Position < ActiveRecord::Base
  resourcify
  
  belongs_to :project
  belongs_to :user
  belongs_to :contract
  has_many :skills

  validates :project, presence: true
  validates :contract_id, presence: true

  acts_as_taggable_on :skills
end
