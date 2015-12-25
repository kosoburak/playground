class UsersController < ApplicationController

  def index
  end

  def show
    user_id = params[:id]
    @user = User.includes(:skills).includes(:evaluations).find(user_id)
    @projects = Project.includes(:karmas)
    .references(:karmas)
    .includes(:participants)
    .references(:projects_users)
    .where('projects_users.user_id = ? or projects.author_id = ?', user_id, user_id)
    .group('projects.id')
    .order('count(karmas.id)')
  end
end
