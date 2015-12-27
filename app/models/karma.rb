class Karma < ActiveRecord::Base
  resourcify
  
  belongs_to :karmable, polymorphic: true
  belongs_to :author, class_name: 'User'
end
