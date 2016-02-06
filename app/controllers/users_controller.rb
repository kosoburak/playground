class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.confirmed.includes(:skills)
    @users = @users.name_like(params[:search_name]) unless params[:search_name].blank?
    @users = @users.locality_like(params[:search_locality]) unless params[:search_locality].blank?
    @users = @users.skills_like(params[:search_skills]) unless params[:search_skills].blank?
    @users = @users.order(:name).page(params[:page])
  end

  def show
    user_id = params[:id]
    @user = User.confirmed.includes(:skills).includes(:evaluations).find(user_id)
    @projects = Project.includes(:karmas)
    .includes(:participants)
    .references(:positions)
    .where('positions.user_id = ? or projects.author_id = ?', user_id, user_id)
  end
end
