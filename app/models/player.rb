class Player < ActiveRecord::Base
  belongs_to :circle
  validates :name, presence: true
  validates :gender, presence: true

  def play
    reset_duration
    add_time
  end

  def not_play
    add_duration
  end

  def back_play
    sub_time
    rollback_duration
  end

  def back_not_play
    sub_duration
  end

  def add_duration
    duration = self.duration + 1
    self.update_attribute(:duration, duration)
  end

  def sub_duration
    duration = self.duration - 1
    self.update_attribute(:duration, duration)
  end

  def reset_duration
    if !self.past_duration.blank?
      past_duration = self.past_duration.split(" ")
      past_duration = past_duration.push(self.duration).join(" ")
    else
      past_duration = self.duration.to_s
    end
    self.update_attribute(:past_duration, past_duration)
    self.update_attribute(:duration, 0)
  end

  def rollback_duration
    duration = self.past_duration.split(" ").last.to_i
    self.update_attribute(:duration, duration)

    past_duration = self.past_duration.split(" ")
    past_duration = past_duration.delete_at(-1)
    past_duration = past_duration.join(" ") if !past_duration.kind_of?(String)
    self.update_attribute(:past_duration, past_duration)
  end

  def add_time
    if self.gender == "male"
      #男子
      case self.method
      when "mix"
        time = self.o_time + 1
        self.update_attribute(:o_time, time)
      when "volley"
        time = self.v_time + 1
        self.update_attribute(:v_time, time)
      else
        #stroke と　manのとき
        time = self.time + 1
        self.update_attribute(:time, time)
      end
    else
      #女子
      case method
      when "mix"
        time = self.o_time + 1
        self.update_attribute(:o_time, time)
      when "volley"
        time = self.v_time + 1
        self.update_attribute(:v_time, time)
      else
        #stroke と　manのとき
        time = self.time + 1
        self.update_attribute(:time, time)
      end
    end

    if self.past_method.blank?
      past_method = self.method
    else
      past_method = self.past_method.split(" ")
      past_method = past_method.push(self.method).join(" ")
    end
    self.update_attribute(:past_method, past_method)
  end

  def sub_time
    past_method = self.past_method.split(" ")
    method = past_method.last
    if self.gender == "male"
      #男子
      case method
      when "mix"
        time = self.o_time - 1
        self.update_attribute(:o_time, time)
      when "volley"
        time = self.v_time - 1
        self.update_attribute(:v_time, time)
      else
        #stroke と　manのとき
        time = self.time - 1
        self.update_attribute(:time, time)
      end
    else
      #女子
      case method
      when "mix"
        time = self.o_time - 1
        self.update_attribute(:o_time, time)
      when "volley"
        time = self.v_time - 1
        self.update_attribute(:v_time, time)
      else
        #stroke と　femaleのとき
        time = self.time - 1
        self.update_attribute(:time, time)
      end
    end
    puts "--------------------"
    past_method.push("test")
    puts past_method
    past_method = past_method.delete_at(-1)
    puts "!!!!!!!!!!!!!!!!!!!!"
    puts past_method
    puts "--------------------"
    past_method = past_method.join(" ") if !past_method.kind_of?(String)
    self.update_attribute(:past_method, past_method)
  end

  # def all_played?
  #   list = self.played_player.split(" ")
  #   now_players = self.circle.players.where(actice: true)
  #   tof = false
  #   now_players.each do |player|
  #     #現在のプレーヤーの中に、対戦したことがない人がいるか
  #     tof =  !list.include?(player)
  #     puts tof
  #     if(tof)
  #       break
  #     end
  #   end
  # end
end
