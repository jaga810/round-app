class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

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
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :circle_id, :gender, :forbidden)
    end
end
