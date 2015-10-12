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

    def add_duration
      duration = self.duration + 1
      self.update_attribute(:duration, duration)
    end

    def reset_duration
      self.update_attribute(:duration, 0)
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
        time = self.time + 1
        self.update_attribute(:time, time)
      end
    end
end
