class Project < ActiveRecord::Base
  resourcify

  belongs_to :author, class_name: 'User'
  has_many :positions, dependent: :destroy
  has_many :participants, class_name: 'User', through: :positions, source: :user
  has_many :comments, dependent: :destroy
  has_many :karmas, as: :karmable, dependent: :destroy

  validates :author, presence: true
  validates :name, presence: true

  def self.number_of_participants(id)
    Project.find(id).participants.distinct.count
  end

  def self.name_like(name)
    where("name LIKE ?", "%#{name}%")
  end

  def self.author_like(author)
    where("author LIKE ?", "%#{author}%")
  end

  def self.locality_like(locality)
    where("locality LIKE ?", "%#{locality}%")
  end
end
