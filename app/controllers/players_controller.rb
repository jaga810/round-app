class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :correct_circle, only: [:edit, :update, :destroy]

  def active
    @method = params[:method]
    @circle = Circle.find(params[:circle_id])
    @group = params[:group]

    case @method
    when "allmen"
      @players = @circle.players.where(gender: "male", group: @group)
      @players = @circle.players.where(gender: "male") if @group.nil?
      @players.each do |player|
        player.update_attribute(:active, false)
      end
    when "allwomen"
      @players = @circle.players.where(gender: "female", group: @group)
      @players = @circle.players.where(gender: "female") if @group.nil?
      @players.each do |player|
        player.update_attribute(:active, false)
      end
    else
      @player = Player.find(params[:player_id])
      active = @player.active
      active = active == true ? false : true

      @player.update_attribute(:active, active )

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
    end

    @tab = params[:tab]
    case params[:page]
    when "practices"
      @practice = Practice.find(params[:practice_id])
      redirect_to :controller => 'practices', :action => 'show', :id => @practice.id, tab: @tab, group: @group
    else
      redirect_to :controller => 'circles', :action => 'show', id: @circle.id, tab: @tab, group: @group
    end
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
      if @now_players.include?(player.id.to_s)
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

      list1.delete(player2.id.to_s)
      list2.delete(player1.id.to_s)

      player1.update_attribute(:played_player, list1.join(" "))
      player2.update_attribute(:played_player, list2.join(" "))
    end
    @round.destroy
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
      next if player.com
      @forbidden_ls.push(player.name)
    end
  end

  # GET /players/1/edit
  def edit
    @circle = @player.circle
    @circle_id = @circle.id

    if !@circle.group.blank?
      @groups = @circle.group.split(" ")
    end
    @forbidden_ls = ["-"]
    @circle.players.each do |player|
      next if player.com
      @forbidden_ls.push(player.name)
    end
  end

  # POST /players
  # POST /players.json
  def create
    @forbidden = player_params[:forbidden]
    if @forbidden == "-"
      @forbidden = nil
    else
      @forbidden = Player.find_by(name: player_params[:forbidden]).id
    end
    name = player_params[:name]
    circle_id = player_params[:circle_id]
    gender = player_params[:gender]
    group = player_params[:group]

    @player = Player.new(name: name, circle_id: circle_id, gender: gender, group: group,forbidden: @forbidden)
    @circle = @player.circle

    if @player.save
      Player.find(@forbidden).update_attribute(:forbidden, @player.id) if @forbidden.present?
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
    forbidden = player_params[:forbidden]
    if forbidden == "-"
      forbidden = nil
    else
      forbidden = Player.find_by(name: player_params[:forbidden]).id
    end
    name = player_params[:name]
    circle_id = player_params[:circle_id]
    gender = player_params[:gender]
    group = player_params[:group]
    @circle = @player.circle

    pre_forbidden = player_params[:pre_forbidden]

    if @player.update(name: name, circle_id: circle_id, gender: gender, group: group,forbidden: forbidden)
      if !pre_forbidden.blank?
        partner = forbidden.nil? ? nil : @player.id
        Player.find(pre_forbidden).update_attribute(:forbidden, partner)
      end
      flash[:success] = "Successfully Changed"
      redirect_to @circle
    else
      @player = Player.new(player_params,params[:gender])
      @circle_id = Circle.find(player_params[:circle_id]).id
      render "new"
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
      params.require(:player).permit(:name, :circle_id, :gender,:group, :forbidden, :pre_forbidden)
    end

    def correct_circle
      @circle = Player.find(params[:id]).circle
      unless current_circle?(@circle)
        flash[:warning] = "Please sign in"
        redirect_to(root_path)
      end
    end
end
