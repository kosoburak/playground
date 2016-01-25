class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.project = @project
    @comment.save
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:project_id])
    @comment = @project.comments.find(params[:id])
    @comment.destroy
    redirect_to project_path(@project)
  end

  private
    def comment_params
      params.require(:comment).permit(:text)
    end
end
