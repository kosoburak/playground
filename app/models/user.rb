class User < ActiveRecord::Base
  resourcify
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :skils
  has_many :positions
  has_many :own_projects, class_name: 'Project', foreign_key: 'author_id'
  has_many :other_projects, class_name: 'Project', through: :positions, source: :project
  has_many :evaluations
  has_many :messages

  validates :name, presence: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", tiny: '30x30' }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  acts_as_taggable_on :skills

  scope :confirmed, -> { where('confirmed_at IS NOT NULL') }

  def project_count
    Project.where('author_id = ?', id).count + Position.includes(:project).references(:project).where('user_id = ? and projects.author_id != ?', id, id).count
  end

  def sent_messages
    Message.includes(:user).where('messages.user_id = ? and messages.from_id = ?', id, id)
  end

  def received_messages
    Message.includes(:user).where('messages.user_id = ? and messages.to_id = ?', id, id)
  end

  def unread_messages
    Message.where('messages.user_id = ? and messages.to_id = ? and messages.read_time is ?', id, id, nil).count('id')
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
