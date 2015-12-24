class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :skils
  has_many :own_projects
  has_and_belongs_to_many :other_projects
  has_many :evaluations
  has_many :messages

  validates :name, presence: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", tiny: '30x30' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  acts_as_taggable_on :skills
end
