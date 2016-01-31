class CommentsController < ApplicationController
  before_action :set_project, only: [:create, :destroy, :karma]

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.project = @project
    @comment.save
    if @comment.errors.any?
      render "projects/show"
    else
      redirect_to project_path(@project)
    end
  end

  def destroy
    @comment = @project.comments.find(params[:id])
    @comment.destroy
    redirect_to project_path(@project)
  end

  def karma
    comment = Comment.find(params[:comment_id])
    karma = Karma.find_by(author: current_user, karmable: comment)
    if karma
      karma.destroy
    else
      karma = Karma.new
      karma.author = current_user
      karma.karmable = comment

      karma.save && karma.author.add_role(:owner, karma)
    end

    redirect_to @project
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
