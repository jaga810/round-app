class CirclesController < ApplicationController
  before_action :set_circle, only: [:show, :edit, :update, :destroy]
  before_action :correct_circle, only: [:show,:edit, :update, :destroy]

  # GET /circles
  # GET /circles.json
  def index
    @circles = Circle.all
  end

  # GET /circles/1
  # GET /circles/1.json
  def show
    @group = params[:circle][:group] if !params[:circle].nil?
    @group = params[:group] if !params[:group].nil?
    @groups = @circle.group.split(" ") if !@circle.group.nil?
    @practices = @circle.practices.all
    if @group.blank? || @group == "All"
      @players = @circle.players.all
    else
      @players = @circle.players.where(group: @group)
    end
    @tab = params[:tab]
  end

  # GET /circles/new
  def new
    @circle = Circle.new
  end

  # GET /circles/1/edit
  def edit
  end

  # POST /circles
  # POST /circles.json
  def create
    @circle = Circle.new(circle_params)
    if @circle.save
      sign_in(@circle)
      @circle.players.create!(name: "-",gender: "com", com: true)
      redirect_to @circle
    else
      render new_circle_path
    end
  end

  # PATCH/PUT /circles/1
  # PATCH/PUT /circles/1.json
  def update
    if @circle.update(circle_params)
      flash[:success] = "Successfully Changed"
      redirect_to @circle
    else
      flash[:error] = "Please try again"
      redirect_to @circle
    end
  end


  # DELETE /circles/1
  # DELETE /circles/1.json
  def destroy
    @circle.destroy
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circle
      @circle = Circle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def circle_params
      params.require(:circle).permit(:name, :email, :password, :password_confirmation, :group)
    end
    def correct_circle
      @circle = Circle.find(params[:id])
      unless current_circle?(@circle)
        flash[:warning] = "Please sign in"
        redirect_to(root_path)
      end
    end
end
