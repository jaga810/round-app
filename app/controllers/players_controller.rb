class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :correct_circle, only: [:edit, :update, :destroy]

  def active
    @circle = Circle.find(params[:circle_id])
    @player = Player.find(params[:player_id])
    active = @player.active
    active = active == true ? false : true

    @player.update_attribute(:active, active)

    @m_list = Player.where(active: true, gender: "male")
    @f_list = Player.where(active: true, gender: "female")

    if active
      if @player.gender == "male"
        avg_time = @m_list.average(:time)
        avg_o_time = @m_list.average(:o_time)
        avg_v_time = @m_list.average(:v_time)

        @player.update_attribute(:v_time, avg_v_time)
        @player.update_attribute(:o_time, avg_o_time)
      else
        avg_time = @f_list.average(:time)
      end


      @player.update_attribute(:time, avg_time)
      @player.update_attribute(:duration, 100)
    end

    redirect_to params[:page]
  end

  # GET /players/new
  def new
    @player = Player.new
    @circle_id = params[:circle_id]
    @circle = Circle.find(@circle_id)
    @groups = @circle.group.split(" ")
  end

  # GET /players/1/edit
  def edit
    @circle = @player.circle
    @circle_id = @circle.id
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params,gender: params[:gender])
    @circle = @player.circle
    puts "gender --------------------------"
    puts player_params[:gender]
    puts params[:gender]
    if @player.save
      redirect_to @circle
    else
      @player = Player.new(player_params,params[:gender])
      @circle_id = Circle.find(player_params[:circle_id]).id
      render "new"
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update

    if @player.update(player_params)
      flash[:success] = "Successfully Changed"
      redirect_to @player.circle
    else
      render 'new'
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @circle = @player.circle
    @player.destroy
    redirect_to @circle
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :circle_id, :gender, :forbidden,:group)
    end

    def correct_circle
      @circle = Player.find(params[:id]).circle
      unless current_circle?(@circle)
        flash[:warning] = "Please sign in"
        redirect_to(root_path)
      end
    end
end
