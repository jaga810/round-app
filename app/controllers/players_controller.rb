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

  def rollback
    @practice = Practice.find(params[:practice_id])
    @circle = @practice.circle
    @round = @practice.rounds.last
    @now_players = @round.now_players.split(" ")
    @m_list = @circle.players.where(gender: "male", active: true)
    @f_list = @circle.players.where(gender: "female", active: true)
    rane = @round.man_rane + @round.mix_rane
    list = @m_list + @f_list

    #対戦回数のrollback
    list.each do |player|
      if @now_players.include?(player.id)
        player.back_play
      else
        player.back_not_play
      end
    end

    #誰と対戦したかのrollback
    for num in 0..rane-1 do
      player1 = Player.find(@now_players[num * 2])
      player2 = Player.find(@now_players[num * 2 + 1])

      next if player1.com || player2.com

      list1 = player1.played_player.split(" ")
      list2 = player2.played_player.split(" ")

      list1.delete(player2.id)
      list2.delete(player1.id)

      player1.update_attribute(:played_player, list1.join(" "))
      player2.update_attribute(:played_player, list2.join(" "))
    end
    redirect_to @practice
  end

  # GET /players/new
  def new
    @player = Player.new
    @circle_id = params[:circle_id]
    @circle = Circle.find(@circle_id)
    if !@circle.group.blank?
      @groups = @circle.group.split(" ")
    end
    @forbidden_ls = ["-"]
    @circle.players.each do |player|
      @forbidden_ls.push(player.name)
    end
  end

  # GET /players/1/edit
  def edit
    @circle = @player.circle
    @circle_id = @circle.id
  end

  # POST /players
  # POST /players.json
  def create
    forbidden = player_params[:forbidden]
    forbidden = forbidden == "-" ? nil : Player.find_by(name: player_params[:forbidden]).id
    name = player_params[:name]
    circle_id = player_params[:circle_id]
    gender = player_params[:gender]
    group = player_params[:group]

    @player = Player.new(name: name, circle_id: circle_id, gender: gender, group: group,forbidden: forbidden)
    @circle = @player.circle

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
      params.require(:player).permit(:name, :circle_id, :gender,:group, :forbidden)
    end

    def correct_circle
      @circle = Player.find(params[:id]).circle
      unless current_circle?(@circle)
        flash[:warning] = "Please sign in"
        redirect_to(root_path)
      end
    end
end
