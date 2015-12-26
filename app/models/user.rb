class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :skils
  has_many :own_projects, class_name: 'Project', foreign_key: 'author_id'
  has_and_belongs_to_many :other_projects, class_name: 'Project'
  has_many :evaluations
  has_many :messages

  validates :name, presence: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", tiny: '30x30' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  acts_as_taggable_on :skills

  def project_count
    User.includes(:own_projects).references(:projects).where('projects.author_id = ?', id).count('projects.id') + User.includes(:other_projects).references(:projects_users).where('projects_users.user_id = ?', id).count('projects_users.project_id')
  end

  def self.name_like(name)
    where("name LIKE ?", "%#{name}%")
  end

  def self.locality_like(locality)
    where("locality LIKE ?", "%#{locality}%")
  end

  def self.skills_like(skills)
    array = []
    array = skills.split(',') if skills
    array.map! { |skill| skill.strip }
    tagged_with(array, :any => true)
  end
end
