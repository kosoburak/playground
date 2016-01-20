class PositionsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :position, :through => :project
  before_action :set_position, only: [:show, :edit, :update, :destroy]

  # GET /positions
  # GET /positions.json
  def index
    @positions = Position.includes(:skills)
  end

  # GET /positions/1
  # GET /positions/1.json
  def show
    position_id = params[:id]
    @position = Position.includes(:skills).find(position_id)
  end

  # GET /positions/new
  def new
    @position = Position.new
  end

  # GET /positions/1/edit
  def edit
  end

  # POST /positions
  # POST /positions.json
  def create
    @position = Position.new(position_params)
    @project = Project.find(params[:project_id])
    @position.project = @project

    respond_to do |format|
      if @position.save && current_user.add_role(:owner, @position)
        format.html { redirect_to @project, notice: 'Position was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /positions/1
  # PATCH/PUT /positions/1.json
  def update
    respond_to do |format|
      if @position.update(position_params)
        format.html { redirect_to @position, notice: 'Position was successfully updated.' }
        format.json { render :show, status: :ok, location: @position }
      else
        format.html { render :edit }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.json
  def destroy
    @position.destroy
    respond_to do |format|
      format.html { redirect_to positions_url, notice: 'Position was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def position_params
      params[:position].permit(:description,:skill_list)
    end
end
