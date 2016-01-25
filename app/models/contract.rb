class Contract < ActiveRecord::Base

  has_many :positions

  validates :contract_name, presence: true
end
