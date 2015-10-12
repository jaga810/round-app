class VsRoundsController < ApplicationController
  include VsRoundsHelper
  before_action :set_round, only: [:destroy]

  # GET /rounds/new
  def new
    @round = Round.new
    @practice_id = params[:practice_id]
    @practice = Practice.find(@practice_id)
    @circle = @practice.circle

    @man_rane = params[:man_rane].to_i
    @mix_rane = params[:mix_rane].to_i

    @m_list = @circle.players.where(gender: "male", active: true)
    @f_list = @circle.players.where(gender: "female", active: true)

    @com = @circle.players.find_by(com: true)

    @now_players = Array.new

    if @man_rane != 0
       man_rane(@man_rane)
    end

    if @mix_rane != 0
       mix_rane(@mix_rane)
    end

    sum = @man_rane + @mix_rane
    s_list = @m_list + @f_list

    play(sum, s_list)

    order = @practice.rounds.count + 1
    @now_players = @now_players.join(",")
    round = @practice.rounds.new(now_players: @now_players,order: order,man_rane: @man_rane, mix_rane: @mix_rane)

    if round.save
      redirect_to @practice
    else
      redirect_to @practice
    end
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(round_params)

    respond_to do |format|
      if @round.save
        format.html { redirect_to @round, notice: 'Round was successfully created.' }
        format.json { render :show, status: :created, location: @round }
      else
        format.html { render :new }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round.destroy
    respond_to do |format|
      format.html { redirect_to rounds_url, notice: 'Round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:practice_id, :order)
    end
end
