class PracticesController < ApplicationController
  before_action :set_practice, only: [:show, :update, :destroy]
  before_action :correct_circle, only: [:show, :update, :destroy ]

  def show
    @circle = @practice.circle
    @rounds = @practice.rounds
    @ranes = @practice.man_rane + @practice.mix_rane

    @group = params[:circle][:group] if !params[:circle].nil?
    @group = params[:group] if !params[:group].nil?
    @groups = @circle.group.split(" ") if !@circle.group.nil?
    if @group.blank? || @group == "All"
      @players = @circle.players.all
    else
      @players = @circle.players.where(group: @group)
    end
    @tab = params[:tab]
  end

  def new
    @practice = Practice.new
    @circle_id = params[:circle_id]
    @circle = Circle.find(@circle_id)
  end

  def create
    @practice = Practice.new(practice_params)
    @practice.circle.practices.last.update_attribute(:active, false) if !@practice.circle.practices.blank?

    players = @practice.circle.players.all
    players.each do |player|
      player.update_attribute(:time,0)
      player.update_attribute(:o_time,0)
      player.update_attribute(:v_time,0)
      player.update_attribute(:duration,0)
      player.update_attribute(:played_player, "noone")
      player.update_attribute(:past_method, nil)
      player.update_attribute(:past_duration, nil)
      if player.forbidden.blank?
        player.update_attribute(:played_player, "nil")
      else
        player.update_attribute(:played_player, player.forbidden)
      end
    end

    if @practice.save
      flash[:success] = "Let's Enjoy Tennis!"
      redirect_to @practice
    else
      flash[:warning] = "Something Wrong"
      render 'new'
    end
  end

  # PATCH/PUT /practices/1
  # PATCH/PUT /practices/1.json
  def update
    if @practice.update(practice_params)
      flash[:success] = "Successfully Changed"
      @circle = @practice.circle
      redirect_to @practice
    else
      puts "fail"
      flash[:warning] = "Changes Denied"
      redirect_to @practice
    end
  end

  # DELETE /practices/1
  # DELETE /practices/1.json
  def destroy
    @practice.destroy
    respond_to do |format|
      format.html { redirect_to practices_url, notice: 'Practice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice
      @practice = Practice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_params
      params.require(:practice).permit(:circle_id, :mix_rane, :man_rane, :method)
    end

    def correct_circle
      @circle = Practice.find(params[:id]).circle
      unless current_circle?(@circle)
        flash[:warning] = "You don't have authority"
        redirect_to(root_path)
      end
    end
end
