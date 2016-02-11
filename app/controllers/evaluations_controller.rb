class EvaluationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_evaluation, only: [:edit, :update, :destroy]
  before_action :set_projects, only: [:edit, :new]
  before_action :set_previous_url, only: [:edit, :new]

  def edit
  end

  def update
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to session[:prev_url] ? session[:prev_url] : :root, notice: 'Evaluation was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def new
    user = User.find(params[:user_id])
    @evaluation = user.evaluations.build
  end

  def create
    user = User.find(params[:user_id])
    @evaluation = user.evaluations.create(evaluation_params)
    @evaluation.author = current_user

    respond_to do |format|
      if @evaluation.save && current_user.add_role(:owner, @evaluation)
        format.html { redirect_to session[:prev_url] ? session[:prev_url] : :root, notice: 'Evaluation was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Evaluation was deleted.' }
    end
  end

  private

  def set_previous_url
    session[:prev_url] = request.referer
  end

  def set_projects
    user_id = params[:user_id]

    @projects = Project.includes(:participants)
    .references(:positions)
    .where('positions.user_id = ? or projects.author_id = ?', user_id, user_id)
    .order('projects.name')

    if @projects.empty?
      redirect_to :root
    end
  end

  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  def evaluation_params
    params.require(:evaluation).permit(:text, :project_id)
  end

end
