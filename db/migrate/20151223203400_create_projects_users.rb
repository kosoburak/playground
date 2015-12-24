class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users, id: false do |t|
      t.belongs_to :project, index: true, null: false
      t.belongs_to :user, index: true, null: false
    end
  end
end
